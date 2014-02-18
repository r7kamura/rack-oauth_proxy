require "json"

module Rack
  class OauthProxy
    class Client
      class Response
        def initialize(raw)
          @raw = raw
        end

        def valid_as_access_token?
          ok? && json? && hash?
        end

        def to_hash
          parsed_body
        end

        private

        def ok?
          @raw.code == "200"
        end

        def json?
          parsed_body
          true
        rescue JSON::ParserError
          false
        end

        def hash?
          parsed_body.is_a?(Hash)
        end

        def parsed_body
          @parsed_body ||= JSON.parse(@raw.body)
        end
      end
    end
  end
end
