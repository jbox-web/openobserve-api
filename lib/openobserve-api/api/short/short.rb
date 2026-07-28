# frozen_string_literal: true

module OpenObserve::Api
  class Short::Short
    def initialize(connection)
      @connection = connection
    end

    def get(short_id:, org_id:, type: nil)
      raise ArgumentError, 'short_id is required' if short_id.nil?
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/short/{org_id}/short/{short_id}'
          .gsub('{short_id}', ERB::Util.url_encode(short_id.to_s))
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: [],
        query: { 'type' => type }
      )
    end
  end
end
