# frozen_string_literal: true

module OpenObserve::Api
  class Api::Streams
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, stream_name:, stream_create_request:, type: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'stream_create_request is required' if stream_create_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/streams/{stream_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'type' => type },
        body: stream_create_request
      )
    end

    def delete(org_id:, stream_name:, delete_all:, type: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'delete_all is required' if delete_all.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/streams/{stream_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'type' => type, 'delete_all' => delete_all }
      )
    end

    def delete_fields(org_id:, stream_name:, stream_delete_fields_request:, type: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'stream_delete_fields_request is required' if stream_delete_fields_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/streams/{stream_name}/delete_fields'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'type' => type },
        body: stream_delete_fields_request
      )
    end

    def list(org_id:, type: nil, keyword: nil, offset: nil, limit: nil, sort: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/streams'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::StreamList200Response,
        auth: ['Authorization'],
        query: { 'type' => type, 'keyword' => keyword, 'offset' => offset, 'limit' => limit, 'sort' => sort }
      )
    end

    def patterns_extract(org_id:, stream_name:, search_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'search_request is required' if search_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/streams/{stream_name}/patterns/extract'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: search_request
      )
    end

    def schema(org_id:, stream_name:, type: nil, keyword: nil, offset: nil, limit: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/streams/{stream_name}/schema'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'type' => type, 'keyword' => keyword, 'offset' => offset, 'limit' => limit }
      )
    end

    def settings(org_id:, stream_name:, update_stream_settings_request:, type: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'update_stream_settings_request is required' if update_stream_settings_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/streams/{stream_name}/settings'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'type' => type },
        body: update_stream_settings_request
      )
    end
  end
end
