# frozen_string_literal: true

module OpenObserve::Api
  class Api::Roles
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, create_roles_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'create_roles_request is required' if create_roles_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/roles'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: create_roles_request
      )
    end

    def delete(org_id:, role_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'role_id is required' if role_id.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/roles/{role_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{role_id}', ERB::Util.url_encode(role_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/roles'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def permissions(org_id:, role_id:, resource:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'role_id is required' if role_id.nil?
      raise ArgumentError, 'resource is required' if resource.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/roles/{role_id}/permissions/{resource}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{role_id}', ERB::Util.url_encode(role_id.to_s))
          .gsub('{resource}', ERB::Util.url_encode(resource.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def update(org_id:, role_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'role_id is required' if role_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/roles/{role_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{role_id}', ERB::Util.url_encode(role_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def users(org_id:, role_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'role_id is required' if role_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/roles/{role_id}/users'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{role_id}', ERB::Util.url_encode(role_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end
  end
end
