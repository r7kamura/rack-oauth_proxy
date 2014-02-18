module Rack
  class OauthProxy
    module AccessTokens
      class Invalid < Base
        def initialize(attributes = nil)
        end

        def accessible?
          false
        end

        def revoked?
          false
        end

        def expired?
          false
        end
      end
    end
  end
end
