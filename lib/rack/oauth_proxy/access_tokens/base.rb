module Rack
  class OauthProxy
    module AccessTokens
      class Base
        ATTRIBUTE_NAMES = %w[
          application_id
          expired_at
          refresh_token
          resource_owner_id
          scope
          token
          token_type
        ]

        ATTRIBUTE_NAMES.each {|name| attr_accessor name }

        def initialize(attributes)
          raise NotImplementedError, "You must implement #{self.class}##{__method__}"
        end

        def accessible?
          raise NotImplementedError, "You must implement #{self.class}##{__method__}"
        end

        def revoked?
          raise NotImplementedError, "You must implement #{self.class}##{__method__}"
        end

        def expired?
          raise NotImplementedError, "You must implement #{self.class}##{__method__}"
        end

        def scopes
          scope.split(" ") if scope
        end
      end
    end
  end
end
