# frozen_string_literal: true

module OpenObserve::Api
  class Client
    attr_reader :configuration, :connection

    def initialize(base_url: nil, **options, &block)
      @configuration = Configuration.new(base_url: base_url, **options, &block)
      @connection = Connection.new(@configuration)
    end

    def _well_known
      @_well_known ||= OpenObserve::Api::WellKnown.new(@connection)
    end

    def api
      @api ||= OpenObserve::Api::Api.new(@connection)
    end

    def healthz
      @healthz ||= OpenObserve::Api::Healthz.new(@connection)
    end

    def rum
      @rum ||= OpenObserve::Api::Rum.new(@connection)
    end

    def service_streams
      @service_streams ||= OpenObserve::Api::ServiceStreams.new(@connection)
    end

    def short
      @short ||= OpenObserve::Api::Short.new(@connection)
    end
  end
end
