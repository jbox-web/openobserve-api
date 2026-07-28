# frozen_string_literal: true

module OpenObserve::Api
  class ServiceStreams
    def initialize(connection)
      @connection = connection
    end

    def _analytics(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/{org_id}/service_streams/_analytics'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::DimensionAnalyticsSummary,
        auth: ['Authorization']
      )
    end

    def _correlate(org_id:, correlation_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'correlation_request is required' if correlation_request.nil?

      @connection.call(
        :POST,
        '/{org_id}/service_streams/_correlate'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::CorrelationResponse,
        auth: ['Authorization'],
        body: correlation_request
      )
    end

    def config_identity(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/{org_id}/service_streams/config/identity'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def config_identity_put(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :PUT,
        '/{org_id}/service_streams/config/identity'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/{org_id}/service_streams'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end
  end
end
