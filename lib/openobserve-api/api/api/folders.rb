# frozen_string_literal: true

module OpenObserve::Api
  class Api::Folders
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, create_folder_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'create_folder_request is required' if create_folder_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/folders'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::Folder,
        auth: ['Authorization'],
        body: create_folder_request
      )
    end

    def dashboards(org_id:, dashboard_id:, move_dashboard_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'dashboard_id is required' if dashboard_id.nil?
      raise ArgumentError, 'move_dashboard_request is required' if move_dashboard_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/folders/dashboards/{dashboard_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{dashboard_id}', ERB::Util.url_encode(dashboard_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: move_dashboard_request
      )
    end

    def delete(org_id:, folder_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'folder_id is required' if folder_id.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/folders/{folder_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{folder_id}', ERB::Util.url_encode(folder_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def get(org_id:, folder_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'folder_id is required' if folder_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/folders/{folder_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{folder_id}', ERB::Util.url_encode(folder_id.to_s)),
        type: OpenObserve::Api::Models::Folder,
        auth: ['Authorization']
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/folders'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::ListFolders200Response,
        auth: ['Authorization']
      )
    end

    def name(org_id:, folder_name:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'folder_name is required' if folder_name.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/folders/name/{folder_name}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{folder_name}', ERB::Util.url_encode(folder_name.to_s)),
        type: OpenObserve::Api::Models::Folder,
        auth: ['Authorization']
      )
    end

    def update(org_id:, folder_id:, update_folder_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'folder_id is required' if folder_id.nil?
      raise ArgumentError, 'update_folder_request is required' if update_folder_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/folders/{folder_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{folder_id}', ERB::Util.url_encode(folder_id.to_s)),
        type: nil,
        auth: ['Authorization'],
        body: update_folder_request
      )
    end
  end
end
