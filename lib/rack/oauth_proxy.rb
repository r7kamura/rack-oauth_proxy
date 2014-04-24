require "rack/oauth_proxy/access_tokens/base"
require "rack/oauth_proxy/access_tokens/invalid"
require "rack/oauth_proxy/access_tokens/valid"
require "rack/oauth_proxy/client"
require "rack/oauth_proxy/client/request"
require "rack/oauth_proxy/version"

module Rack
  class OauthProxy
    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def call(env)
      env["rack-oauth_proxy.access_token"] = client.fetch(env)
      @app.call(env)
    end

    private

    def client
      @client ||= Client.new(@options)
    end
  end
end
