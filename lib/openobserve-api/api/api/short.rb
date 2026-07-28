# frozen_string_literal: true

module OpenObserve::Api
  class Api::Short
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, create_short_url_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'create_short_url_request is required' if create_short_url_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/short'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::CreateShortUrl200Response,
        auth: [],
        body: create_short_url_request
      )
    end
  end
end
