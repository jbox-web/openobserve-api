# CLAUDE.md

Project instructions for agents working in this repository.

## Layering — where a change belongs

This gem is the **transport socle**. Its intended consumer is `openobserve-client`, a thin
hand-written business wrapper — **planned, not written yet**. Until it exists, callers talk to
this gem directly and absorb the rough edges themselves; that is a temporary state, not the
target architecture.

| Concern | Lives in |
| --- | --- |
| HTTP, auth, (de)serialization, path building | **`openobserve-api`** — here, generated |
| The `api` sub-client hop (`client.api.summary(org_id:)`) | `openobserve-client` |
| Reaching deep resources the generator gives no accessor for | `openobserve-client` |
| Basic credentials handed to `api_key:` because no operation declares `BasicAuth` | `openobserve-client` |
| Microsecond timestamps, ingestion-visibility polling, pagination ergonomics | `openobserve-client` |
| Value objects, single error surface, domain accessors | `openobserve-client` |

Each of those rough edges is described in full below (see *The spec is committed verbatim* and
*Authentication*); this table says **where they get smoothed over**, not what they are.

**Arbitration.** Anything that makes the raw API *nicer* belongs one floor up. The only changes
that belong here go through the pinned spec + `mise run generate`. Hand-written smoothing in
`lib/**` is not merely off-style: the next regeneration drops it silently, so the bug it papered
over comes back without a trace.

## Generated code — never hand-edit

`lib/**` and the generated specs (`spec/api/**`, `spec/models/**`, `spec/spec_helper.rb`) are
**100% generated** by openapi-generator. Do not edit them by hand — any change is lost on the
next regeneration. Every change goes through the pinned OpenAPI spec + `mise run generate`.

The only hand-maintained files are those listed in `.openapi-generator-ignore`
(README, this file, `mise.toml`, `versions/`, `.github/`, `.gitignore`, `spec/e2e/`,
`docker-compose.e2e.yml`).

## Generator

The generator is `-g ruby-nextgen`, upstream in openapi-generator since **7.24.0**. The version
is pinned by `OPENAPI_GENERATOR_VERSION` in `mise.toml`, and the `generate` task cross-checks
`openapi-generator version` against that pin — a mismatch fails the task instead of silently
producing different code.

Locally the generator comes from Homebrew (`brew install openapi-generator`); CI has no formula
and downloads the released jar from Maven Central, pointing `OPENAPI_GENERATOR_CMD` at it (see
`.github/workflows/regenerate.yml`). To change generated output, land the change in
openapi-generator upstream, then bump the pin here.

## The spec is committed verbatim

`versions/openobserve-rest.v<version>.json` is the byte-for-byte output of the instance's own
`/api-doc/openapi.json`. It is **never** patched. That is what makes the weekly `regenerate`
workflow meaningful: a diff means the server changed, not that our transformation drifted.

Two consequences follow, and both are intentional — do not "fix" them:

- **The `api` hop.** Sub-clients follow URL segments, not tags. Every route under `/api/` lands
  on `client.api`, so it reads `client.api.summary(org_id:)`. Ten routes live outside `/api`
  (`/healthz`, `/rum/v1/…`, `/short/…`, `/{org_id}/service_streams`, `/.well-known/…`) and get
  their own top-level sub-clients. Stripping the `/api` prefix from the spec would flatten the
  namespace but break those ten.
- **No accessor for deeper resources.** `OpenObserve::Api::Api::Alerts` and its 20 siblings
  exist as classes but their parent exposes no accessor; instantiate them with
  `.new(client.connection)`. This is generator-wide behaviour, identical in `dolibarr-api`
  (`Dolibarr::Api::Invoices::Lines`) — not an OpenObserve quirk.

## Authentication — `BasicAuth` is declared but never referenced

The spec declares both `BasicAuth` and `Authorization`, but **no operation references
`BasicAuth`**: all 210 authenticated operations declare `Authorization` only. Since
`Configuration#apply_auth` applies exactly the schemes the called operation declares,
`username:` / `password:` are dead options against this spec. Pass HTTP Basic as the raw header
value through `api_key:` (`"Basic #{["#{user}:#{pass}"].pack('m0')}"` — core Ruby, no `base64`
stdlib dependency, which stopped being a default gem in 3.4).

## Module shape — hard invariant

Every generated file uses the hybrid form `module OpenObserve::Api` (compact module) + nested
body:

```ruby
module OpenObserve::Api
  class Client
    ...
  end
end
```

This wrapper is **semantically required**: it keeps `OpenObserve::Api` in the lexical scope so
unqualified sibling constants (`Configuration`, `Connection`, `Response`, `ApiError`, models)
resolve. Fully-compact `class OpenObserve::Api::Client` raises
`NameError: uninitialized constant OpenObserve::Api::Client::Configuration`. RuboCop's
`Style/ClassAndModuleChildren` has no mode that accepts this valid idiom, so it is **disabled**
in the generated `.rubocop.yml`. Do NOT "fix" the module shape to nested or compact.

## RuboCop — `format` is NOT a no-op here

Validate with `bin/rubocop` (**the whole project**) — never `rubocop lib`, which under-scopes
and hides offenses in the gemspec, Rakefile, and specs.

Unlike `dolibarr-api`, the generated code is **not** rubocop-clean by construction on this spec:
the generator emits one `Style/IfUnlessModifier` offense in
`lib/openobserve-api/configuration.rb`. `mise run format` autocorrects it
(`bundle exec rubocop -A lib`), which is why `mise run build` = generate + format and why
`regenerate.yml` installs dependencies **before** building. Keeping `bin/rubocop` at zero
offenses is the point: one tolerated offense is how the next one gets missed.

## Validate a regeneration

```sh
mise run dev:deps                        # rubocop must be available for `format`
mise run build                           # purge + generate from the pinned spec + autocorrect
bin/rubocop                              # => 0 offenses across the whole project
bundle exec rspec spec/api spec/models   # => all green (offline, no network)
```

Regeneration must be idempotent: a second `mise run build` produces no diff (the CI in
`.github/workflows/regenerate.yml` asserts `git diff --exit-code`).

## Secrets & pinned version

- Credentials come **only** from the environment: `OPENOBSERVE_BASE_URL`, `OPENOBSERVE_USER`,
  `OPENOBSERVE_PASSWORD`. Never hard-code or commit them.
- The OpenObserve version is pinned in `mise.toml` (`OPENOBSERVE_VERSION`); bump it deliberately,
  and fetch the matching spec from that release (see README).
- `spec/e2e/**` writes for real against a **disposable** dockerized instance. Never point it at a
  live one.
