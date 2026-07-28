# frozen_string_literal: true

module OpenObserve::Api
  class Api::V2
    def initialize(connection)
      @connection = connection
    end

    def alerts(org_id:, folder: nil, stream_type: nil, stream_name: nil, alert_name_substring: nil, owner: nil, enabled: nil, page_size: nil, page_idx: nil, alert_type: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/v2/{org_id}/alerts'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::ListAlerts200Response,
        auth: ['Authorization'],
        query: { 'folder' => folder, 'stream_type' => stream_type, 'stream_name' => stream_name, 'alert_name_substring' => alert_name_substring, 'owner' => owner, 'enabled' => enabled, 'page_size' => page_size, 'page_idx' => page_idx, 'alert_type' => alert_type }
      )
    end

    def alerts_bulk_enable(org_id:, value:, enable_alert_bulk_request:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'value is required' if value.nil?
      raise ArgumentError, 'enable_alert_bulk_request is required' if enable_alert_bulk_request.nil?

      @connection.call(
        :POST,
        '/api/v2/{org_id}/alerts/bulk/enable'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'value' => value, 'folder' => folder },
        body: enable_alert_bulk_request
      )
    end

    def alerts_clone(org_id:, alert_id:, clone_alert_request:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'alert_id is required' if alert_id.nil?
      raise ArgumentError, 'clone_alert_request is required' if clone_alert_request.nil?

      @connection.call(
        :POST,
        '/api/v2/{org_id}/alerts/{alert_id}/clone'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{alert_id}', ERB::Util.url_encode(alert_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'folder' => folder },
        body: clone_alert_request
      )
    end

    def alerts_delete(org_id:, alert_id:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'alert_id is required' if alert_id.nil?

      @connection.call(
        :DELETE,
        '/api/v2/{org_id}/alerts/{alert_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{alert_id}', ERB::Util.url_encode(alert_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'folder' => folder }
      )
    end

    def alerts_enable(org_id:, alert_id:, value:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'alert_id is required' if alert_id.nil?
      raise ArgumentError, 'value is required' if value.nil?

      @connection.call(
        :PATCH,
        '/api/v2/{org_id}/alerts/{alert_id}/enable'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{alert_id}', ERB::Util.url_encode(alert_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'value' => value, 'folder' => folder }
      )
    end

    def alerts_export(org_id:, alert_id:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'alert_id is required' if alert_id.nil?

      @connection.call(
        :POST,
        '/api/v2/{org_id}/alerts/{alert_id}/export'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{alert_id}', ERB::Util.url_encode(alert_id.to_s)),
        type: OpenObserve::Api::Models::Alert,
        auth: ['Authorization'],
        query: { 'folder' => folder }
      )
    end

    def alerts_generate_sql(org_id:, generate_sql_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'generate_sql_request is required' if generate_sql_request.nil?

      @connection.call(
        :POST,
        '/api/v2/{org_id}/alerts/generate_sql'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::GenerateSql200Response,
        auth: ['Authorization'],
        body: generate_sql_request
      )
    end

    def alerts_get(org_id:, alert_id:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'alert_id is required' if alert_id.nil?

      @connection.call(
        :GET,
        '/api/v2/{org_id}/alerts/{alert_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{alert_id}', ERB::Util.url_encode(alert_id.to_s)),
        type: OpenObserve::Api::Models::Alert,
        auth: ['Authorization'],
        query: { 'folder' => folder }
      )
    end

    def alerts_incidents(org_id:, status: nil, limit: nil, offset: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/v2/{org_id}/alerts/incidents'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::ListIncidentsResponse,
        auth: ['Authorization'],
        query: { 'status' => status, 'limit' => limit, 'offset' => offset }
      )
    end

    def alerts_incidents_get(org_id:, incident_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'incident_id is required' if incident_id.nil?

      @connection.call(
        :GET,
        '/api/v2/{org_id}/alerts/incidents/{incident_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{incident_id}', ERB::Util.url_encode(incident_id.to_s)),
        type: OpenObserve::Api::Models::IncidentWithAlerts,
        auth: ['Authorization']
      )
    end

    def alerts_incidents_rca(org_id:, incident_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'incident_id is required' if incident_id.nil?

      @connection.call(
        :POST,
        '/api/v2/{org_id}/alerts/incidents/{incident_id}/rca'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{incident_id}', ERB::Util.url_encode(incident_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def alerts_incidents_stats(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/v2/{org_id}/alerts/incidents/stats'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::IncidentStats,
        auth: ['Authorization']
      )
    end

    def alerts_incidents_update(org_id:, incident_id:, update_payload:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'incident_id is required' if incident_id.nil?
      raise ArgumentError, 'update_payload is required' if update_payload.nil?

      @connection.call(
        :PATCH,
        '/api/v2/{org_id}/alerts/incidents/{incident_id}/update'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{incident_id}', ERB::Util.url_encode(incident_id.to_s)),
        type: OpenObserve::Api::Models::Incident,
        auth: ['Authorization'],
        body: update_payload
      )
    end

    def alerts_move(org_id:, move_alerts_request:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'move_alerts_request is required' if move_alerts_request.nil?

      @connection.call(
        :PATCH,
        '/api/v2/{org_id}/alerts/move'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'folder' => folder },
        body: move_alerts_request
      )
    end

    def alerts_post(org_id:, create_alert_request:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'create_alert_request is required' if create_alert_request.nil?

      @connection.call(
        :POST,
        '/api/v2/{org_id}/alerts'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'folder' => folder },
        body: create_alert_request
      )
    end

    def alerts_put(org_id:, alert_id:, update_alert_request:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'alert_id is required' if alert_id.nil?
      raise ArgumentError, 'update_alert_request is required' if update_alert_request.nil?

      @connection.call(
        :PUT,
        '/api/v2/{org_id}/alerts/{alert_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{alert_id}', ERB::Util.url_encode(alert_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'folder' => folder },
        body: update_alert_request
      )
    end

    def alerts_retrain(org_id:, alert_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'alert_id is required' if alert_id.nil?

      @connection.call(
        :PATCH,
        '/api/v2/{org_id}/alerts/{alert_id}/retrain'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{alert_id}', ERB::Util.url_encode(alert_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def alerts_trigger(org_id:, alert_id:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'alert_id is required' if alert_id.nil?

      @connection.call(
        :PATCH,
        '/api/v2/{org_id}/alerts/{alert_id}/trigger'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{alert_id}', ERB::Util.url_encode(alert_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'folder' => folder }
      )
    end

    def folders(org_id:, folder_type:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'folder_type is required' if folder_type.nil?

      @connection.call(
        :GET,
        '/api/v2/{org_id}/folders/{folder_type}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{folder_type}', ERB::Util.url_encode(folder_type.to_s)),
        type: OpenObserve::Api::Models::ListFolders200Response,
        auth: ['Authorization']
      )
    end

    def folders_delete(org_id:, folder_type:, folder_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'folder_type is required' if folder_type.nil?
      raise ArgumentError, 'folder_id is required' if folder_id.nil?

      @connection.call(
        :DELETE,
        '/api/v2/{org_id}/folders/{folder_type}/{folder_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{folder_type}', ERB::Util.url_encode(folder_type.to_s))
          .gsub('{folder_id}', ERB::Util.url_encode(folder_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def folders_get(org_id:, folder_type:, folder_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'folder_type is required' if folder_type.nil?
      raise ArgumentError, 'folder_id is required' if folder_id.nil?

      @connection.call(
        :GET,
        '/api/v2/{org_id}/folders/{folder_type}/{folder_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{folder_type}', ERB::Util.url_encode(folder_type.to_s))
          .gsub('{folder_id}', ERB::Util.url_encode(folder_id.to_s)),
        type: OpenObserve::Api::Models::Folder,
        auth: ['Authorization']
      )
    end

    def folders_name(org_id:, folder_type:, folder_name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'folder_type is required' if folder_type.nil?
      raise ArgumentError, 'folder_name is required' if folder_name.nil?

      @connection.call(
        :GET,
        '/api/v2/{org_id}/folders/{folder_type}/name/{folder_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{folder_type}', ERB::Util.url_encode(folder_type.to_s))
          .gsub('{folder_name}', ERB::Util.url_encode(folder_name.to_s)),
        type: OpenObserve::Api::Models::Folder,
        auth: ['Authorization']
      )
    end

    def folders_post(org_id:, folder_type:, create_folder_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'folder_type is required' if folder_type.nil?
      raise ArgumentError, 'create_folder_request is required' if create_folder_request.nil?

      @connection.call(
        :POST,
        '/api/v2/{org_id}/folders/{folder_type}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{folder_type}', ERB::Util.url_encode(folder_type.to_s)),
        type: OpenObserve::Api::Models::Folder,
        auth: ['Authorization'],
        body: create_folder_request
      )
    end

    def folders_put(org_id:, folder_type:, folder_id:, update_folder_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'folder_type is required' if folder_type.nil?
      raise ArgumentError, 'folder_id is required' if folder_id.nil?
      raise ArgumentError, 'update_folder_request is required' if update_folder_request.nil?

      @connection.call(
        :PUT,
        '/api/v2/{org_id}/folders/{folder_type}/{folder_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{folder_type}', ERB::Util.url_encode(folder_type.to_s))
          .gsub('{folder_id}', ERB::Util.url_encode(folder_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: update_folder_request
      )
    end

    def reports(org_id:, folder: nil, dashboard_id: nil, cache: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/v2/{org_id}/reports'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: [OpenObserve::Api::Models::ListReportsV2200ResponseInner],
        auth: ['Authorization'],
        query: { 'folder' => folder, 'dashboard_id' => dashboard_id, 'cache' => cache }
      )
    end

    def reports_bulk(org_id:, bulk_delete_request:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'bulk_delete_request is required' if bulk_delete_request.nil?

      @connection.call(
        :DELETE,
        '/api/v2/{org_id}/reports/bulk'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::BulkDeleteResponse,
        auth: ['Authorization'],
        query: { 'folder' => folder },
        body: bulk_delete_request
      )
    end

    def reports_delete(org_id:, report_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'report_id is required' if report_id.nil?

      @connection.call(
        :DELETE,
        '/api/v2/{org_id}/reports/{report_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{report_id}', ERB::Util.url_encode(report_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def reports_enable(org_id:, report_id:, value:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'report_id is required' if report_id.nil?
      raise ArgumentError, 'value is required' if value.nil?

      @connection.call(
        :PATCH,
        '/api/v2/{org_id}/reports/{report_id}/enable'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{report_id}', ERB::Util.url_encode(report_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'value' => value }
      )
    end

    def reports_get(org_id:, report_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'report_id is required' if report_id.nil?

      @connection.call(
        :GET,
        '/api/v2/{org_id}/reports/{report_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{report_id}', ERB::Util.url_encode(report_id.to_s)),
        type: OpenObserve::Api::Models::ListReportsV2200ResponseInner,
        auth: ['Authorization']
      )
    end

    def reports_move(org_id:, move_reports_request:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'move_reports_request is required' if move_reports_request.nil?

      @connection.call(
        :PATCH,
        '/api/v2/{org_id}/reports/move'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'folder' => folder },
        body: move_reports_request
      )
    end

    def reports_post(org_id:, list_reports_v2200_response_inner:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'list_reports_v2200_response_inner is required' if list_reports_v2200_response_inner.nil?

      @connection.call(
        :POST,
        '/api/v2/{org_id}/reports'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'folder' => folder },
        body: list_reports_v2200_response_inner
      )
    end

    def reports_put(org_id:, report_id:, list_reports_v2200_response_inner:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'report_id is required' if report_id.nil?
      raise ArgumentError, 'list_reports_v2200_response_inner is required' if list_reports_v2200_response_inner.nil?

      @connection.call(
        :PUT,
        '/api/v2/{org_id}/reports/{report_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{report_id}', ERB::Util.url_encode(report_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'folder' => folder },
        body: list_reports_v2200_response_inner
      )
    end

    def reports_trigger(org_id:, report_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'report_id is required' if report_id.nil?

      @connection.call(
        :PUT,
        '/api/v2/{org_id}/reports/{report_id}/trigger'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{report_id}', ERB::Util.url_encode(report_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end
  end
end
