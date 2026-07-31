# openobserve-api

[![CI](https://github.com/jbox-web/openobserve-api/actions/workflows/ci.yml/badge.svg)](https://github.com/jbox-web/openobserve-api/actions/workflows/ci.yml)
[![regenerate](https://github.com/jbox-web/openobserve-api/actions/workflows/regenerate.yml/badge.svg)](https://github.com/jbox-web/openobserve-api/actions/workflows/regenerate.yml)
[![docs](https://github.com/jbox-web/openobserve-api/actions/workflows/docs.yml/badge.svg)](https://jbox-web.github.io/openobserve-api/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Low-level REST client for the [OpenObserve API](https://openobserve.ai/), **100% generated**
by [openapi-generator](https://openapi-generator.tech) (`-g ruby-nextgen`) from the instance's
OpenAPI spec. A generic gem with no business logic: multi-instance,
[Faraday](https://github.com/lostisland/faraday), [Zeitwerk](https://github.com/fxn/zeitwerk),
per-resource namespaced sub-clients.

- Verified target: **OpenObserve 0.91.4** (OpenAPI 3.1.0, 150 paths, 261 schemas, 33 tags).
- Pinned and committed spec: [`versions/openobserve-rest.v0.91.4.json`](versions/openobserve-rest.v0.91.4.json),
  served by the instance itself on `/api-doc/openapi.json` (Swagger UI on `/swagger`, gated by
  `ZO_SWAGGER_ENABLED`, which defaults to `true`).

> ⚠️ **`lib/` is entirely generated — never edit it by hand.**
> Every change goes through the spec + `mise run generate`. The only hand-maintained files are
> listed in [`.openapi-generator-ignore`](.openapi-generator-ignore)
> (README, CLAUDE.md, `mise.toml`, `versions/`, `.github/`, `.gitignore`, `spec/e2e/`,
> `docker-compose.e2e.yml`).

## Installation

```ruby
# Gemfile
gem 'openobserve-api', git: 'https://github.com/jbox-web/openobserve-api.git'
```

```sh
bundle install
```

## Configuration (environment variables)

Secrets are **never** hard-coded or committed — only supplied through the environment:

| Variable                   | Purpose                                |
| -------------------------- | -------------------------------------- |
| `OPENOBSERVE_BASE_URL`     | e.g. `https://openobserve.example.org` |
| `OPENOBSERVE_USER`         | account e-mail                         |
| `OPENOBSERVE_PASSWORD`     | account password                       |

## Usage

A multi-instance `Client` carries the base URL and the credential; sub-clients are namespaced
per resource:

```ruby
require 'openobserve-api'

# pack('m0') is strict Base64 from core Ruby — no `base64` stdlib dependency.
credential = ["#{ENV.fetch('OPENOBSERVE_USER')}:#{ENV.fetch('OPENOBSERVE_PASSWORD')}"].pack('m0')

client = OpenObserve::Api::Client.new(
  base_url: ENV.fetch('OPENOBSERVE_BASE_URL'),
  api_key:  "Basic #{credential}"
)

response = client.api.summary(org_id: 'default')
response.status   # => 200
response.data     # => Hash
```

### Authentication — pass Basic through `api_key:`

The spec declares two security schemes, `BasicAuth` and `Authorization`, but **no operation
references `BasicAuth`**: all 210 authenticated operations declare `Authorization` only, an
apiKey sent as a raw `Authorization` header. The transport applies exactly the schemes an
operation declares, so `Configuration#username` / `#password` are **never** used against this
spec — they are dead options here.

The server does expect HTTP Basic. Build the header value yourself and hand it to `api_key:`,
as above. A long-lived token works the same way — it is the raw header value either way.

### TLS behind a private CA — `ssl:`

An OpenObserve served by a private authority (step-ca in a container stack, for instance) is
unreachable out of the box: the default trust store holds public authorities only, and every
request dies on `certificate verify failed (unable to get local issuer certificate)`.

`ssl` is handed to Faraday verbatim, so anything the adapter understands works:

```ruby
client = OpenObserve::Api::Client.new(
  base_url: "https://openobserve.internal:8443",
  api_key:  "Basic #{["#{user}:#{password}"].pack('m0')}",
  ssl:      { ca_file: "/path/to/root.crt" }
)
```

It cannot be supplied any other way — `Configuration#use` appends middlewares, and Faraday
settles TLS as it builds the connection, before any middleware runs.

The option comes from the `ruby-nextgen` templates, upstreamed as
[openapi-generator#24536](https://github.com/OpenAPITools/openapi-generator/pull/24536) and
overridden locally under `templates/` until a release carries it — see [Regeneration](#regeneration).

### Sub-client shape — mind the `api` hop

Sub-clients follow the **URL segments**, not the OpenAPI tags. Every OpenObserve route lives
under `/api/`, so it lands on the `api` sub-client — one hop more than you may expect. `Client`
exposes six sub-clients, one per distinct first URL segment:

```ruby
client.api               # /api/...          — 44 operations, the bulk of the API
client.healthz.list      # GET /healthz
client.rum.v1            # /rum/v1/{org_id}/...
client.short.short       # /short/{org_id}/short/{short_id}
client.service_streams   # /{org_id}/service_streams
client._well_known       # /.well-known/oauth-authorization-server

client.api.summary(org_id: 'default')       # GET /api/{org_id}/summary
client.api.organizations                    # GET /api/organizations
client.api.clusters                         # GET /api/clusters
```

This is a deliberate trade-off: the pinned spec is committed **verbatim**, exactly as the server
publishes it. Rewriting paths to flatten the namespace would break the ten routes that live
outside `/api`, and would make the `regenerate` workflow compare against a patched artefact
instead of the real thing.

### Reaching the deeper resources

Deeper URL segments generate their own classes (`Alerts`, `Streams`, `Dashboards`, `Folders`,
`Functions`, `Kv`, `Pipelines`, `Reports`, `Roles`, `Savedviews`, `SearchJobs`,
`ServiceAccounts`, `Traces`, `Users`, `V1`, `V2`, …) but the generator emits **no accessor** for
them on their parent — the same is true of `dolibarr-api` (`Dolibarr::Api::Invoices::Lines`).
Instantiate them with the client's connection:

```ruby
alerts = OpenObserve::Api::Api::Alerts.new(client.connection)
alerts.templates(org_id: 'default')             # GET /api/{org_id}/alerts/templates

streams = OpenObserve::Api::Api::Streams.new(client.connection)
streams.list(org_id: 'default')                 # GET /api/{org_id}/streams

v2 = OpenObserve::Api::Api::V2.new(client.connection)
v2.alerts(org_id: 'default')                    # GET /api/v2/{org_id}/alerts
```

Wrapping those in a friendlier facade is the job of a higher-level gem — this one stays a
generated transport with no hand-written code.

### Ingest, then search

```ruby
client.api._json(
  org_id: 'default',
  stream_name: 'canary',
  body: [{ level: 'info', message: 'hello' }]
)

client.api._search(
  org_id: 'default',
  search_sql_request: OpenObserve::Api::Models::SearchSQLRequest.new(
    query: OpenObserve::Api::Models::SearchQuery.new(
      sql:        'SELECT * FROM canary',
      start_time: (Time.now.to_i - 3600) * 1_000_000,   # microseconds
      end_time:   (Time.now.to_i + 60) * 1_000_000,
      from:       0,
      size:       10
    )
  )
)
```

Timestamps are **microseconds** since the epoch, and ingestion is not synchronous — a freshly
ingested row needs a moment before it is searchable (see the e2e canary, which polls instead of
sleeping).

## Regeneration

```sh
mise run generate   # purge lib/ + generate from the pinned spec (-g ruby-nextgen)
mise run build      # generate + format
mise run dev:spec   # spec suite
```

> **Generator.** `ruby-nextgen` is upstream in openapi-generator since 7.24.0. The version is
> pinned by `OPENAPI_GENERATOR_VERSION` in [`mise.toml`](mise.toml) and cross-checked by the
> `generate` task. Install it locally with `brew install openapi-generator`; CI downloads the
> released jar — see [`.github/workflows/regenerate.yml`](.github/workflows/regenerate.yml).

> **Template override — temporary.** `generate` passes `-t templates/ruby-nextgen`, which holds
> three templates and only those; the generator falls back to the ones embedded in the pinned jar
> for every other file, so the pinned version still produces all the rest. They add the `ssl`
> configuration option, without which an OpenObserve behind a private CA is unreachable.
> Upstreamed as [openapi-generator#24536](https://github.com/OpenAPITools/openapi-generator/pull/24536):
> once a release carries it, bump `OPENAPI_GENERATOR_VERSION`, delete `templates/` and drop the
> `-t` flag.

Unlike a fully clean generation, this spec makes the generator emit **one** autocorrectable
RuboCop offense, so `mise run format` is not a no-op here: it runs `bundle exec rubocop -A lib`,
which is why `bin/rubocop` reports zero offenses. Dependencies must therefore be installed
before `mise run build`.

To bump the pinned OpenObserve version, fetch the spec from that release and regenerate:

```sh
docker run -d --name oo-spec -p 127.0.0.1:7005:5080 \
  -e ZO_ROOT_USER_EMAIL=root@example.com -e ZO_ROOT_USER_PASSWORD='Complexpass#123' \
  public.ecr.aws/zinclabs/openobserve:v<version>
curl -sf http://localhost:7005/api-doc/openapi.json -o versions/openobserve-rest.v<version>.json
docker rm -f oo-spec
# then bump OPENOBSERVE_VERSION in mise.toml and run `mise run build`
```

## Tests

- Generated **network-free** unit specs (model round-trips, sub-client resolution).
- An **e2e canary** (`mise run e2e`) that spins up a disposable OpenObserve, ingests a log line
  and searches it back, then tears everything down. Opt-in: the spec self-gates on
  `OPENOBSERVE_E2E`.

## License

MIT — see [LICENSE](LICENSE).
