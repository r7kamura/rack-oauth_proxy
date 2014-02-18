require "rack/oauth_proxy/version"

module Rack
  class OauthProxy
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    end
  end
end
