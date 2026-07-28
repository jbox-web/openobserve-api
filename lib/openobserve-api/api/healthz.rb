# frozen_string_literal: true

module OpenObserve::Api
  class Healthz
    def initialize(connection)
      @connection = connection
    end

    def list
      @connection.call(
        :GET,
        '/healthz',
        type: OpenObserve::Api::Models::HealthCheck200Response,
        auth: []
      )
    end
  end
end
