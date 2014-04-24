require "active_support/core_ext/hash/slice"
require "json"
require "rack"

module Rack
  class OauthProxy
    class Client
      class Request
        def initialize(env)
          @env = env
        end

        def to_header
          {
            "Authorization" => authorization,
            "Resource-Owner-Id" => resource_owner_id,
          }.reject {|key, value| value.nil? }
        end

        def rack_request
          @rack_request ||= Rack::Request.new(@env)
        end

        def to_params
          rack_request.params.slice("access_token", "bearer_token")
        end

        def authorization
          @env["HTTP_AUTHORIZATION"]
        end

        def resource_owner_id
          @env["HTTP_RESOURCE_OWNER_ID"]
        end
      end
    end
  end
end
