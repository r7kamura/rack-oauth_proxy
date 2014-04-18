require "active_support/core_ext/hash/slice"
require "active_support/core_ext/object/blank"
require "active_support/core_ext/object/to_query"
require "rack"

module Rack
  class OauthProxy
    class Client
      class Request
        def initialize(env)
          @env = env
        end

        def has_any_valid_credentials?
          authorization.present? ||
            rack_request.params["access_token"].present? ||
            rack_request.params["bearer_token"].present?
        end

        def rack_request
          @rack_request ||= Rack::Request.new(@env)
        end

        def to_query
          rack_request.params.slice("access_token", "bearer_token").to_query
        end

        def authorization
          @env["HTTP_AUTHORIZATION"]
        end

        def resource_owner_id
          @env["HTTP_RESOURCE_OWNER_ID"]
        end

        def scopes
          @env["HTTP_SCOPES"]
        end
      end
    end
  end
end
