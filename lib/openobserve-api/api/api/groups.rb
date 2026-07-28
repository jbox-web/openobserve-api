# frozen_string_literal: true

module OpenObserve::Api
  class Api::Groups
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, create_group_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'create_group_request is required' if create_group_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/groups'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: create_group_request
      )
    end

    def delete(org_id:, group_name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'group_name is required' if group_name.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/groups/{group_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{group_name}', ERB::Util.url_encode(group_name.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def get(org_id:, group_name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'group_name is required' if group_name.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/groups/{group_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{group_name}', ERB::Util.url_encode(group_name.to_s)),
        type: OpenObserve::Api::Models::CreateGroupRequest,
        auth: ['Authorization']
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/groups'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def update(org_id:, group_name:, update_group_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'group_name is required' if group_name.nil?
      raise ArgumentError, 'update_group_request is required' if update_group_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/groups/{group_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{group_name}', ERB::Util.url_encode(group_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: update_group_request
      )
    end
  end
end
