# frozen_string_literal: true

module OpenObserve::Api
  class Api::CipherKeys
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/cipher_keys'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: []
      )
    end

    def delete(key_name:, org_id:)
      raise ArgumentError, 'key_name is required' if key_name.nil?
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/cipher_keys/{key_name}'
          .gsub('{key_name}', ERB::Util.url_encode(key_name.to_s))
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: []
      )
    end

    def get(key_name:, org_id:)
      raise ArgumentError, 'key_name is required' if key_name.nil?
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/cipher_keys/{key_name}'
          .gsub('{key_name}', ERB::Util.url_encode(key_name.to_s))
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: []
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/cipher_keys'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: []
      )
    end

    def update(org_id:, key_name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'key_name is required' if key_name.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/cipher_keys/{key_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{key_name}', ERB::Util.url_encode(key_name.to_s)),
        type: nil,
        auth: []
      )
    end
  end
end
