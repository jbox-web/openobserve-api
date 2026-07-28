# frozen_string_literal: true

module OpenObserve::Api
  class Api::Alerts
    def initialize(connection)
      @connection = connection
    end

    def dedup_summary(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/alerts/dedup/summary'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::DedupSummaryResponse,
        auth: ['Authorization']
      )
    end

    def deduplication_config(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/alerts/deduplication/config'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def deduplication_config_delete(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/alerts/deduplication/config'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def deduplication_config_post(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/alerts/deduplication/config'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def deduplication_semantic_groups(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/alerts/deduplication/semantic-groups'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def deduplication_semantic_groups_preview_diff(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/alerts/deduplication/semantic-groups/preview-diff'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def deduplication_semantic_groups_put(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/alerts/deduplication/semantic-groups'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def destinations(org_id:, module_: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/alerts/destinations'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: [OpenObserve::Api::Models::ListDestinations200ResponseInner],
        auth: ['Authorization'],
        query: { 'module' => module_ }
      )
    end

    def destinations_delete(org_id:, destination_name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'destination_name is required' if destination_name.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/alerts/destinations/{destination_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{destination_name}', ERB::Util.url_encode(destination_name.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def destinations_get(org_id:, destination_name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'destination_name is required' if destination_name.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/alerts/destinations/{destination_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{destination_name}', ERB::Util.url_encode(destination_name.to_s)),
        type: OpenObserve::Api::Models::ListDestinations200ResponseInner,
        auth: ['Authorization']
      )
    end

    def destinations_post(org_id:, list_destinations200_response_inner:, module_: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'list_destinations200_response_inner is required' if list_destinations200_response_inner.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/alerts/destinations'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'module' => module_ },
        body: list_destinations200_response_inner
      )
    end

    def destinations_put(org_id:, destination_name:, list_destinations200_response_inner:, module_: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'destination_name is required' if destination_name.nil?
      raise ArgumentError, 'list_destinations200_response_inner is required' if list_destinations200_response_inner.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/alerts/destinations/{destination_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{destination_name}', ERB::Util.url_encode(destination_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'module' => module_ },
        body: list_destinations200_response_inner
      )
    end

    def history(org_id:, alert_id: nil, start_time: nil, end_time: nil, from: nil, size: nil, sort_by: nil, sort_order: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/alerts/history'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::GetAlertHistory200Response,
        auth: ['Authorization'],
        query: { 'alert_id' => alert_id, 'start_time' => start_time, 'end_time' => end_time, 'from' => from, 'size' => size, 'sort_by' => sort_by, 'sort_order' => sort_order }
      )
    end

    def templates(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/alerts/templates'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: [OpenObserve::Api::Models::ListTemplates200ResponseInner],
        auth: ['Authorization']
      )
    end

    def templates_delete(org_id:, template_name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'template_name is required' if template_name.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/alerts/templates/{template_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{template_name}', ERB::Util.url_encode(template_name.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def templates_get(org_id:, template_name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'template_name is required' if template_name.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/alerts/templates/{template_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{template_name}', ERB::Util.url_encode(template_name.to_s)),
        type: OpenObserve::Api::Models::ListTemplates200ResponseInner,
        auth: ['Authorization']
      )
    end

    def templates_post(org_id:, list_templates200_response_inner:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'list_templates200_response_inner is required' if list_templates200_response_inner.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/alerts/templates'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: list_templates200_response_inner
      )
    end

    def templates_put(org_id:, template_name:, list_templates200_response_inner:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'template_name is required' if template_name.nil?
      raise ArgumentError, 'list_templates200_response_inner is required' if list_templates200_response_inner.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/alerts/templates/{template_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{template_name}', ERB::Util.url_encode(template_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: list_templates200_response_inner
      )
    end

    def templates_system_prebuilt(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/alerts/templates/system/prebuilt'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: [OpenObserve::Api::Models::ListTemplates200ResponseInner],
        auth: ['Authorization']
      )
    end
  end
end
