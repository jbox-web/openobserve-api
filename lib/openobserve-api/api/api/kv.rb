# frozen_string_literal: true

module OpenObserve::Api
  class Api::Kv
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, key:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'key is required' if key.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/kv/{key}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{key}', ERB::Util.url_encode(key.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def delete(org_id:, key:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'key is required' if key.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/kv/{key}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{key}', ERB::Util.url_encode(key.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def get(org_id:, key:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'key is required' if key.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/kv/{key}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{key}', ERB::Util.url_encode(key.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def list(org_id:, prefix: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/kv'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'prefix' => prefix }
      )
    end
  end
end
