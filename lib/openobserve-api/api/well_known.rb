# frozen_string_literal: true

module OpenObserve::Api
  class WellKnown
    def initialize(connection)
      @connection = connection
    end

    def oauth_authorization_server
      @connection.call(
        :POST,
        '/.well-known/oauth-authorization-server',
        type: nil,
        auth: []
      )
    end
  end
end
