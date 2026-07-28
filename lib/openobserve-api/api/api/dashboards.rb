# frozen_string_literal: true

module OpenObserve::Api
  class Api::Dashboards
    def initialize(connection)
      @connection = connection
    end

    def annotations(start_time:, end_time:, org_id:, dashboard_id:, panels: nil)
      raise ArgumentError, 'start_time is required' if start_time.nil?
      raise ArgumentError, 'end_time is required' if end_time.nil?
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/dashboards/{dashboard_id}/annotations'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s)),
        type: [OpenObserve::Api::Models::TimedAnnotation],
        auth: ['Authorization'],
        query: { 'panels' => panels, 'start_time' => start_time, 'end_time' => end_time }
      )
    end

    def annotations_delete(org_id:, dashboard_id:, delete_annotations_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?
      raise ArgumentError, 'delete_annotations_request is required' if delete_annotations_request.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/dashboards/{dashboard_id}/annotations'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: delete_annotations_request
      )
    end

    def annotations_panels(org_id:, dashboard_id:, timed_annotation_id:, request_body:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?
      raise ArgumentError, 'timed_annotation_id is required' if timed_annotation_id.nil?
      raise ArgumentError, 'request_body is required' if request_body.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/dashboards/{dashboard_id}/annotations/panels/{timed_annotation_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s))
          .gsub('{timed_annotation_id}', ERB::Util.url_encode(timed_annotation_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: request_body
      )
    end

    def annotations_post(org_id:, dashboard_id:, create_annotations_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?
      raise ArgumentError, 'create_annotations_request is required' if create_annotations_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/dashboards/{dashboard_id}/annotations'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s)),
        type: [OpenObserve::Api::Models::TimedAnnotation],
        auth: ['Authorization'],
        body: create_annotations_request
      )
    end

    def annotations_put(org_id:, dashboard_id:, timed_annotation_id:, update_annotations_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?
      raise ArgumentError, 'timed_annotation_id is required' if timed_annotation_id.nil?
      raise ArgumentError, 'update_annotations_request is required' if update_annotations_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/dashboards/{dashboard_id}/annotations/{timed_annotation_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s))
          .gsub('{timed_annotation_id}', ERB::Util.url_encode(timed_annotation_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: update_annotations_request
      )
    end

    def create(org_id:, dashboard:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard is required' if dashboard.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/dashboards'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::Dashboard,
        auth: ['Authorization'],
        query: { 'folder' => folder },
        body: dashboard
      )
    end

    def delete(org_id:, dashboard_id:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/dashboards/{dashboard_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        query: { 'folder' => folder }
      )
    end

    def get(org_id:, dashboard_id:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/dashboards/{dashboard_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s)),
        type: OpenObserve::Api::Models::Dashboard,
        auth: ['Authorization'],
        query: { 'folder' => folder }
      )
    end

    def list(org_id:, folder: nil, title: nil, page_size: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/dashboards'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::ListDashboards200Response,
        auth: ['Authorization'],
        query: { 'folder' => folder, 'title' => title, 'pageSize' => page_size }
      )
    end

    def move(org_id:, move_dashboards_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'move_dashboards_request is required' if move_dashboards_request.nil?

      @connection.call(
        :PATCH,
        '/api/{org_id}/dashboards/move'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: move_dashboards_request
      )
    end

    def panels(org_id:, dashboard_id:, hash:, add_panel_request:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?
      raise ArgumentError, 'hash is required' if hash.nil?
      raise ArgumentError, 'add_panel_request is required' if add_panel_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/dashboards/{dashboard_id}/panels'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s)),
        type: OpenObserve::Api::Models::AddPanel200Response,
        auth: ['Authorization'],
        query: { 'folder' => folder, 'hash' => hash },
        body: add_panel_request
      )
    end

    def panels_delete(org_id:, dashboard_id:, panel_id:, hash:, folder: nil, tab_id: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?
      raise ArgumentError, 'panel_id is required' if panel_id.nil?
      raise ArgumentError, 'hash is required' if hash.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/dashboards/{dashboard_id}/panels/{panel_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s))
          .gsub('{panel_id}', ERB::Util.url_encode(panel_id.to_s)),
        type: OpenObserve::Api::Models::DeletePanel200Response,
        auth: ['Authorization'],
        query: { 'folder' => folder, 'hash' => hash, 'tabId' => tab_id }
      )
    end

    def panels_put(org_id:, dashboard_id:, panel_id:, hash:, add_panel_request:, folder: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?
      raise ArgumentError, 'panel_id is required' if panel_id.nil?
      raise ArgumentError, 'hash is required' if hash.nil?
      raise ArgumentError, 'add_panel_request is required' if add_panel_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/dashboards/{dashboard_id}/panels/{panel_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s))
          .gsub('{panel_id}', ERB::Util.url_encode(panel_id.to_s)),
        type: OpenObserve::Api::Models::AddPanel200Response,
        auth: ['Authorization'],
        query: { 'folder' => folder, 'hash' => hash },
        body: add_panel_request
      )
    end

    def update(org_id:, dashboard_id:, folder:, dashboard:, hash: nil)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?
      raise ArgumentError, 'folder is required' if folder.nil?
      raise ArgumentError, 'dashboard is required' if dashboard.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/dashboards/{dashboard_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s)),
        type: OpenObserve::Api::Models::Dashboard,
        auth: ['Authorization'],
        query: { 'folder' => folder, 'hash' => hash },
        body: dashboard
      )
    end
  end
end
