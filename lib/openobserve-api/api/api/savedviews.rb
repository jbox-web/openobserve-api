# frozen_string_literal: true

module OpenObserve::Api
  class Api::Savedviews
    def initialize(connection)
      @connection = connection
    end

    def create(org_id:, create_saved_views_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'create_saved_views_request is required' if create_saved_views_request.nil?

      @connection.call(
        :POST,
        '/api/{org_id}/savedviews'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: OpenObserve::Api::Models::CreateSavedViews200Response,
        auth: ['Authorization'],
        body: create_saved_views_request
      )
    end

    def delete(org_id:, view_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'view_id is required' if view_id.nil?

      @connection.call(
        :DELETE,
        '/api/{org_id}/savedviews/{view_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{view_id}', ERB::Util.url_encode(view_id.to_s)),
        type: OpenObserve::Api::Models::DeleteSavedViews200Response,
        auth: ['Authorization']
      )
    end

    def get(org_id:, view_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'view_id is required' if view_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/savedviews/{view_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{view_id}', ERB::Util.url_encode(view_id.to_s)),
        type: OpenObserve::Api::Models::GetSavedView200Response,
        auth: ['Authorization']
      )
    end

    def list(org_id:)
      raise ArgumentError, 'org_id is required' if org_id.nil?

      @connection.call(
        :GET,
        '/api/{org_id}/savedviews'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s)),
        type: nil,
        auth: ['Authorization']
      )
    end

    def update(org_id:, view_id:, create_saved_views_request:)
      raise ArgumentError, 'org_id is required' if org_id.nil?
      raise ArgumentError, 'view_id is required' if view_id.nil?
      raise ArgumentError, 'create_saved_views_request is required' if create_saved_views_request.nil?

      @connection.call(
        :PUT,
        '/api/{org_id}/savedviews/{view_id}'
          .gsub('{org_id}', ERB::Util.url_encode(org_id.to_s))
          .gsub('{view_id}', ERB::Util.url_encode(view_id.to_s)),
        type: OpenObserve::Api::Models::GetSavedView200Response,
        auth: ['Authorization'],
        body: create_saved_views_request
      )
    end
  end
end
