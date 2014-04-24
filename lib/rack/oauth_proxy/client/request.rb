require "active_support/core_ext/hash/slice"
require "json"
require "rack"

module Rack
  class OauthProxy
    class Client
      class Request
        DEFAULT_PROPAGATED_HEADER_FIELDS = ["Authorization"]

        attr_reader :env, :options

        def initialize(env, options = {})
          @env = env
          @options = options
        end

        def header
          header_with_nil_value.reject {|key, value| value.nil? }
        end

        def header_with_nil_value
          propagated_header_fields.inject({}) do |result, field|
            result.merge(field => env["HTTP_" + field.gsub("-", "_").upcase])
          end
        end

        def params
          rack_request.params.slice("access_token", "bearer_token")
        end

        private

        def rack_request
          @rack_request ||= Rack::Request.new(@env)
        end

        def propagated_header_fields
          options[:propagated_header_fields] || DEFAULT_PROPAGATED_HEADER_FIELDS
        end
      end
    end
  end
end
