# frozen_string_literal: true

module OpenObserve::Api
  class Api::Reports
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, list_reports_v2200_response_inner:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'list_reports_v2200_response_inner is required' if list_reports_v2200_response_inner.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/reports'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: list_reports_v2200_response_inner
      )
    end

    def delete(org_id:, name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'name is required' if name.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/reports/{name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{name}', ERB::Util.url_encode(name.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def enable(org_id:, name:, value:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'name is required' if name.nil?
      raise ArgumentError, 'value is required' if value.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/reports/{name}/enable'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{name}', ERB::Util.url_encode(name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'value' => value }
      )
    end

    def get(org_id:, name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'name is required' if name.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/reports/{name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{name}', ERB::Util.url_encode(name.to_s)),
        type: OpenObserve::Api::Models::ListReportsV2200ResponseInner,
        auth: ['Authorization']
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/reports'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: [OpenObserve::Api::Models::ListReportsV2200ResponseInner],
        auth: ['Authorization']
      )
    end

    def trigger(org_id:, name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'name is required' if name.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/reports/{name}/trigger'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{name}', ERB::Util.url_encode(name.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def update(org_id:, name:, list_reports_v2200_response_inner:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'name is required' if name.nil?
      raise ArgumentError, 'list_reports_v2200_response_inner is required' if list_reports_v2200_response_inner.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/reports/{name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{name}', ERB::Util.url_encode(name.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: list_reports_v2200_response_inner
      )
    end
  end
end
