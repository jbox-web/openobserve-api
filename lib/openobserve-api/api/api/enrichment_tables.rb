# frozen_string_literal: true

module OpenObserve::Api
  class Api::EnrichmentTables
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, table_name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'table_name is required' if table_name.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/enrichment_tables/{table_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{table_name}', ERB::Util.url_encode(table_name.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def url(org_id:, table_name:, enrichment_table_url_request:, append: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'table_name is required' if table_name.nil?
      raise ArgumentError, 'enrichment_table_url_request is required' if enrichment_table_url_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/enrichment_tables/{table_name}/url'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{table_name}', ERB::Util.url_encode(table_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'append' => append },
        body: enrichment_table_url_request
      )
    end
  end
end
