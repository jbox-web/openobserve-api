# frozen_string_literal: true

module OpenObserve::Api
  class Api::ServiceAccounts
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, service_account_save_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'service_account_save_request is required' if service_account_save_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/service_accounts'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: service_account_save_request
      )
    end

    def delete(org_id:, email_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'email_id is required' if email_id.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/service_accounts/{email_id}'
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
        '/api/{org_id}/service_accounts'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def update(org_id:, email_id:, service_account_update_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'email_id is required' if email_id.nil?
      raise ArgumentError, 'service_account_update_request is required' if service_account_update_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/service_accounts/{email_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{email_id}', ERB::Util.url_encode(email_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: service_account_update_request
      )
    end
  end
end
