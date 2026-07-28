# frozen_string_literal: true

module OpenObserve::Api
  class Rum::V1
    def initialize(connection)
      @connection = connection
    end

    def logs(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/rum/v1/{org_id}/logs'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def replay(org_id:, event:, segment:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'event is required' if event.nil?
      raise ArgumentError, 'segment is required' if segment.nil?

      @connection.call(
        :POST,
        '/rum/v1/{org_id}/replay'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        form: { 'event' => event, 'segment' => segment }
      )
    end

    def rum(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/rum/v1/{org_id}/rum'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end
  end
end
