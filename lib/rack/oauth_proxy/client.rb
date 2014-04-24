require "faraday"
require "faraday_middleware"

module Rack
  class OauthProxy
    class Client
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def fetch(env)
        request = Request.new(env, options)
        connection.get(url, request.params, request.header)
      end

      private

      def connection
        @connection ||= Faraday.new(headers: header) do |connection|
          connection.adapter :net_http
          connection.response :json
        end
      end

      def url
        options[:url] or raise NoUrlError
      end

      def host
        options[:host]
      end

      def header
        {
          "Host" => host,
        }.reject {|key, value| value.nil? }
      end

      class NoUrlError < StandardError
      end
    end
  end
end
