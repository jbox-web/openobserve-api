# frozen_string_literal: true

module OpenObserve::Api
  class Api::Users
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, user_save_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'user_save_request is required' if user_save_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/users'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: user_save_request
      )
    end

    def create_post(org_id:, email_id:, create_roles_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'email_id is required' if email_id.nil?
      raise ArgumentError, 'create_roles_request is required' if create_roles_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/users/{email_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{email_id}', ERB::Util.url_encode(email_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: create_roles_request
      )
    end

    def delete(org_id:, email_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'email_id is required' if email_id.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/users/{email_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{email_id}', ERB::Util.url_encode(email_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/users'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def update(org_id:, email_id:, user_update_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'email_id is required' if email_id.nil?
      raise ArgumentError, 'user_update_request is required' if user_update_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/users/{email_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{email_id}', ERB::Util.url_encode(email_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: user_update_request
      )
    end
  end
end
