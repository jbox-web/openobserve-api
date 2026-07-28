# frozen_string_literal: true

require 'open3'
require 'net/http'

# Lifecycle of the disposable OpenObserve used by the e2e canary.
#
# Owned here rather than by the mise task so a bare `rspec spec/e2e` still works: the task only
# arms the suite (OPENOBSERVE_E2E) and installs a teardown backstop. Everything this module
# talks to is throwaway — see docker-compose.e2e.yml.
module E2E
  module Instance
    COMPOSE_FILE = File.expand_path('../../../docker-compose.e2e.yml', __dir__)
    BASE_URL     = 'http://localhost:7005'
    ORG          = 'default'

    # Test-only credentials, matching docker-compose.e2e.yml. Not a secret: the instance is
    # created and destroyed by this file and only ever listens on loopback.
    USER     = 'root@example.com'
    PASSWORD = 'Complexpass#123'

    # How long the container may take to answer /healthz. Generous: a cold CI runner pulls the
    # image first.
    BOOT_TIMEOUT = 180

    module_function

    # `pack('m0')` is strict Base64 from core Ruby — the `base64` stdlib stopped being a default
    # gem in 3.4, and the generated Gemfile is not ours to add it to.
    def credential
      "Basic #{["#{USER}:#{PASSWORD}"].pack('m0')}"
    end

    def client
      OpenObserve::Api::Client.new(base_url: BASE_URL, api_key: credential)
    end

    def up
      compose('up', '-d')
      wait_until(BOOT_TIMEOUT, 'OpenObserve to answer /healthz') { healthy? }
    end

    def down
      compose('down', '-v')
    end

    def healthy?
      uri = URI("#{BASE_URL}/healthz")
      Net::HTTP.start(uri.host, uri.port, open_timeout: 2, read_timeout: 2) do |http|
        http.get(uri.request_uri).is_a?(Net::HTTPSuccess)
      end
    rescue StandardError
      false
    end

    # Returns the hits for `needle` in `stream`, or [] while the row is not searchable yet.
    # Timestamps are microseconds since the epoch; the window is wide on purpose so a clock skew
    # between host and container cannot hide a freshly ingested row.
    def search(client, stream, needle)
      now = Process.clock_gettime(Process::CLOCK_REALTIME, :microsecond)

      response = client.api._search(
        org_id: ORG,
        search_sql_request: OpenObserve::Api::Models::SearchSQLRequest.new(
          query: OpenObserve::Api::Models::SearchQuery.new(
            sql: "SELECT * FROM #{stream} WHERE message = '#{needle}'",
            start_time: now - (3600 * 1_000_000),
            end_time: now + (3600 * 1_000_000),
            from: 0,
            size: 10
          )
        )
      )

      response.data['hits'] || []
    rescue OpenObserve::Api::ApiError
      # The stream does not exist until the first ingested row is flushed; an error here is a
      # not-yet, not a failure.
      []
    end

    # Polls instead of sleeping: both readiness and ingestion visibility are "eventually true"
    # with no published bound, so a fixed sleep is either flaky or wasteful.
    def wait_until(timeout, what)
      deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + timeout
      loop do
        result = yield
        return result if result
        raise "timed out after #{timeout}s waiting for #{what}" if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline

        sleep 1
      end
    end

    def compose(*args)
      out, status = Open3.capture2e('docker', 'compose', '-f', COMPOSE_FILE, *args)
      raise "docker compose #{args.join(' ')} failed:\n#{out}" unless status.success?

      out
    end
  end
end
