# frozen_string_literal: true

module OpenObserve::Api
  class Api
    def initialize(connection)
      @connection = connection
    end

    def _around(org_id:, stream_name:, key:, size:, type: nil, regions: nil, timeout: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'key is required' if key.nil?
      raise ArgumentError, 'size is required' if size.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/{stream_name}/_around'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'type' => type, 'key' => key, 'size' => size, 'regions' => regions, 'timeout' => timeout }
      )
    end

    def _around_post(org_id:, stream_name:, size:, body:, regions: nil, timeout: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'size is required' if size.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/{stream_name}/_around'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'size' => size, 'regions' => regions, 'timeout' => timeout },
        body: body
      )
    end

    def _bulk(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/_bulk'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def _json(org_id:, stream_name:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/{stream_name}/_json'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def _multi(org_id:, stream_name:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/{stream_name}/_multi'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def _search(org_id:, search_sql_request:, type: nil, is_ui_histogram: nil, is_multi_stream_search: nil, validate: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'search_sql_request is required' if search_sql_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/_search'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'type' => type, 'is_ui_histogram' => is_ui_histogram, 'is_multi_stream_search' => is_multi_stream_search, 'validate' => validate },
        body: search_sql_request
      )
    end

    def _search_history(org_id:, search_history_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'search_history_request is required' if search_history_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/_search_history'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: search_history_request
      )
    end

    def _search_partition(org_id:, search_partition_request:, type: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'search_partition_request is required' if search_partition_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/_search_partition'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'type' => type },
        body: search_partition_request
      )
    end

    def _search_stream(org_id:, is_ui_histogram:, is_multi_stream_search:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'is_ui_histogram is required' if is_ui_histogram.nil?
      raise ArgumentError, 'is_multi_stream_search is required' if is_multi_stream_search.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/_search_stream'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'is_ui_histogram' => is_ui_histogram, 'is_multi_stream_search' => is_multi_stream_search },
        body: body
      )
    end

    def _values(org_id:, stream_name:, fields:, size:, from:, start_time:, end_time:, type: nil, filter: nil, keyword: nil, regions: nil, timeout: nil, no_count: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'stream_name is required' if stream_name.nil?
      raise ArgumentError, 'fields is required' if fields.nil?
      raise ArgumentError, 'size is required' if size.nil?
      raise ArgumentError, 'from is required' if from.nil?
      raise ArgumentError, 'start_time is required' if start_time.nil?
      raise ArgumentError, 'end_time is required' if end_time.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/{stream_name}/_values'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{stream_name}', ERB::Util.url_encode(stream_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'type' => type, 'fields' => fields, 'filter' => filter, 'keyword' => keyword, 'size' => size, 'from' => from, 'start_time' => start_time, 'end_time' => end_time, 'regions' => regions, 'timeout' => timeout, 'no_count' => no_count }
      )
    end

    def _values_stream(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/_values_stream'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def clusters
      @connection.call(
        :GET,
        '/api/clusters',
        type: nil,
        auth: ['Authorization']
      )
    end

    def ingest_metrics__json(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/ingest/metrics/_json'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def loki_api_v1_push(org_id:, logs_ingestion_loki_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'logs_ingestion_loki_request is required' if logs_ingestion_loki_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/loki/api/v1/push'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: logs_ingestion_loki_request
      )
    end

    def mcp(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/mcp'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def organizations
      @connection.call(
        :GET,
        '/api/organizations',
        type: OpenObserve::Api::Models::GetUserOrganizations200Response,
        auth: ['Authorization']
      )
    end

    def organizations_assume_service_account(org_id:, assume_service_account_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'assume_service_account_request is required' if assume_service_account_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/organizations/assume_service_account'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::AssumeServiceAccountResponse,
        auth: ['Authorization'],
        body: assume_service_account_request
      )
    end

    def organizations_post(create_organization_request:)
      raise ArgumentError, 'create_organization_request is required' if create_organization_request.nil?

      @connection.call(
        :POST,
        '/api/organizations',
        type: OpenObserve::Api::Models::CreateOrganization200Response,
        auth: ['Authorization'],
        body: create_organization_request
      )
    end

    def passcode(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/passcode'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::GetOrganizationUserIngestToken200Response,
        auth: ['Authorization']
      )
    end

    def passcode_put(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/passcode'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::GetOrganizationUserIngestToken200Response,
        auth: ['Authorization']
      )
    end

    def prometheus_api_v1_format_query(query:, org_id:)
      raise ArgumentError, 'query is required' if query.nil?
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/prometheus/api/v1/format_query'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'query' => query }
      )
    end

    def prometheus_api_v1_label_values(org_id:, label_name:, match:, start: nil, end_: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'label_name is required' if label_name.nil?
      raise ArgumentError, 'match is required' if match.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/prometheus/api/v1/label/{label_name}/values'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{label_name}', ERB::Util.url_encode(label_name.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'match[]' => match, 'start' => start, 'end' => end_ }
      )
    end

    def prometheus_api_v1_labels(org_id:, match:, start: nil, end_: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'match is required' if match.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/prometheus/api/v1/labels'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'match[]' => match, 'start' => start, 'end' => end_ }
      )
    end

    def prometheus_api_v1_metadata(org_id:, limit:, metric: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'limit is required' if limit.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/prometheus/api/v1/metadata'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'limit' => limit, 'metric' => metric }
      )
    end

    def prometheus_api_v1_query(org_id:, query:, time: nil, timeout: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'query is required' if query.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/prometheus/api/v1/query'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'query' => query, 'time' => time, 'timeout' => timeout }
      )
    end

    def prometheus_api_v1_query_range(org_id:, query:, start:, end_:, step: nil, timeout: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'query is required' if query.nil?
      raise ArgumentError, 'start is required' if start.nil?
      raise ArgumentError, 'end_ is required' if end_.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/prometheus/api/v1/query_range'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'query' => query, 'start' => start, 'end' => end_, 'step' => step, 'timeout' => timeout }
      )
    end

    def prometheus_api_v1_series(org_id:, match:, start: nil, end_: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'match is required' if match.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/prometheus/api/v1/series'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'match[]' => match, 'start' => start, 'end' => end_ }
      )
    end

    def prometheus_api_v1_write(org_id:, body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/prometheus/api/v1/write'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: body
      )
    end

    def ratelimit_module_list(org_id:, org_id2:, interval: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'org_id2 is required' if org_id2.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/ratelimit/module_list'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'org_id' => org_id2, 'interval' => interval }
      )
    end

    def ratelimit_role_list(org_id:, org_id2:, user_role:, interval: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'org_id2 is required' if org_id2.nil?
      raise ArgumentError, 'user_role is required' if user_role.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/ratelimit/role_list'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'org_id' => org_id2, 'user_role' => user_role, 'interval' => interval }
      )
    end

    def ratelimit_update(org_id:, org_id2:, update_type:, body:, user_role: nil, interval: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'org_id2 is required' if org_id2.nil?
      raise ArgumentError, 'update_type is required' if update_type.nil?
      raise ArgumentError, 'body is required' if body.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/ratelimit/update'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'org_id' => org_id2, 'update_type' => update_type, 'user_role' => user_role, 'interval' => interval },
        body: body
      )
    end

    def rename(org_id:, rename_organization_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'rename_organization_request is required' if rename_organization_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/rename'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::CreateOrganizationRequest,
        auth: ['Authorization'],
        body: rename_organization_request
      )
    end

    def rumtoken(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/rumtoken'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::GetOrganizationUserRumIngestToken200Response,
        auth: ['Authorization']
      )
    end

    def rumtoken_post(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/rumtoken'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::GetOrganizationUserRumIngestToken200Response,
        auth: ['Authorization']
      )
    end

    def rumtoken_put(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/rumtoken'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::GetOrganizationUserRumIngestToken200Response,
        auth: ['Authorization']
      )
    end

    def settings(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/settings'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def settings_post(org_id:, organization_setting_create_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'organization_setting_create_request is required' if organization_setting_create_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/settings'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: organization_setting_create_request
      )
    end

    def settings_v2(org_id:, user_id: nil, category: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/settings/v2'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'user_id' => user_id, 'category' => category }
      )
    end

    def settings_v2_delete(org_id:, key:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'key is required' if key.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/settings/v2/{key}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{key}', ERB::Util.url_encode(key.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def settings_v2_get(org_id:, key:, user_id: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'key is required' if key.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/settings/v2/{key}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{key}', ERB::Util.url_encode(key.to_s)),
        type: OpenObserve::Api::Models::SystemSetting,
        auth: ['Authorization'],
        query: { 'user_id' => user_id }
      )
    end

    def settings_v2_post(org_id:, system_setting_payload:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'system_setting_payload is required' if system_setting_payload.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/settings/v2'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::SystemSetting,
        auth: ['Authorization'],
        body: system_setting_payload
      )
    end

    def settings_v2_user(org_id:, user_id:, system_setting_payload:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'user_id is required' if user_id.nil?
      raise ArgumentError, 'system_setting_payload is required' if system_setting_payload.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/settings/v2/user/{user_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{user_id}', ERB::Util.url_encode(user_id.to_s)),
        type: OpenObserve::Api::Models::SystemSetting,
        auth: ['Authorization'],
        body: system_setting_payload
      )
    end

    def settings_v2_user_delete(org_id:, user_id:, key:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'user_id is required' if user_id.nil?
      raise ArgumentError, 'key is required' if key.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/settings/v2/user/{user_id}/{key}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{user_id}', ERB::Util.url_encode(user_id.to_s))
          .gsub('{key}', ERB::Util.url_encode(key.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def summary(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/summary'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end
  end
end
