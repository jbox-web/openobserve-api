# frozen_string_literal: true

module OpenObserve::Api
  class Api::V1
    def initialize(connection)
      @connection = connection
    end

    def traces(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/v1/traces'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end
  end
end
