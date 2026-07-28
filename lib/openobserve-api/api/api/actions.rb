# frozen_string_literal: true

module OpenObserve::Api
  class Api::Actions
    def initialize(connection)
      @connection = connection
    end

    def delete(org_id:, ksuid:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'ksuid is required' if ksuid.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/actions/{ksuid}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{ksuid}', ERB::Util.url_encode(ksuid.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def download(org_id:, ksuid:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'ksuid is required' if ksuid.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/actions/download/{ksuid}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{ksuid}', ERB::Util.url_encode(ksuid.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def get(org_id:, action_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'action_id is required' if action_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/actions/{action_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{action_id}', ERB::Util.url_encode(action_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/actions'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def update(org_id:, action_id:, update_action_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'action_id is required' if action_id.nil?
      raise ArgumentError, 'update_action_request is required' if update_action_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/actions/{action_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{action_id}', ERB::Util.url_encode(action_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: update_action_request
      )
    end

    def upload(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/actions/upload'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end
  end
end
