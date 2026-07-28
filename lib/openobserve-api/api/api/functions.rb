# frozen_string_literal: true

module OpenObserve::Api
  class Api::Functions
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, create_function_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'create_function_request is required' if create_function_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/functions'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: create_function_request
      )
    end

    def delete(org_id:, name:, force:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'name is required' if name.nil?
      raise ArgumentError, 'force is required' if force.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/functions/{name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{name}', ERB::Util.url_encode(name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'force' => force }
      )
    end

    def get(org_id:, name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'name is required' if name.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/functions/{name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{name}', ERB::Util.url_encode(name.to_s)),
        type: OpenObserve::Api::Models::ListFunctions200Response,
        auth: ['Authorization']
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/functions'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::ListFunctions200Response,
        auth: ['Authorization']
      )
    end

    def test(org_id:, test_function_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'test_function_request is required' if test_function_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/functions/test'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: test_function_request
      )
    end

    def update(org_id:, name:, create_function_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'name is required' if name.nil?
      raise ArgumentError, 'create_function_request is required' if create_function_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/functions/{name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{name}', ERB::Util.url_encode(name.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: create_function_request
      )
    end
  end
end
