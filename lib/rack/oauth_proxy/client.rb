require "net/http"

module Rack
  class OauthProxy
    class Client
      READ_TIMEOUT = 1
      OPEN_TIMEOUT = 1

      def initialize(options = {})
        @options = options
      end

      def fetch(env)
        request = Request.new(env)
        if request.has_any_valid_credentials?
          path = "#{uri.path}"
          path << "?#{request.to_query}" if request.to_query.present?
          header = {
            "Authorization" => request.authorization,
            "Host" => host,
            "Resource-Owner-Id" => request.resource_owner_id,
            "Scopes" => request.scopes,
          }.reject {|key, value| value.nil? }
          raw_response = http_client.get(path, header)
          response = Response.new(raw_response)
          if response.valid_as_access_token?
            AccessTokens::Valid.new(response.to_hash)
          else
            AccessTokens::Invalid.new
          end
        else
          AccessTokens::Invalid.new
        end
      rescue Timeout::Error
        AccessTokens::Invalid.new
      end

      private

      def uri
        @uri ||= URI.parse(url)
      end

      def http_client
        client = Net::HTTP.new(uri.host, uri.port)
        client.read_timeout = READ_TIMEOUT
        client.open_timeout = OPEN_TIMEOUT
        client
      end

      def url
        @options[:url] or raise NoUrlError
      end

      def host
        @options[:host]
      end

      class NoUrlError < StandardError
      end
    end
  end
end
