module Rack
  class OauthProxy
    module AccessTokens
      class Valid < Base
        def initialize(attributes)
          ATTRIBUTE_NAMES.each {|name| send("#{name}=", attributes[name]) }
        end

        def accessible?
          true
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
