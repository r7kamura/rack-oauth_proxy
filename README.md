# Rack::OauthProxy [![Build Status](https://travis-ci.org/r7kamura/rack-oauth_proxy.png)](https://travis-ci.org/r7kamura/rack-oauth_proxy) [![Code Climate](https://codeclimate.com/github/r7kamura/rack-oauth_proxy.png)](https://codeclimate.com/github/r7kamura/rack-oauth_proxy) [![Code Climate](https://codeclimate.com/github/r7kamura/rack-oauth_proxy/coverage.png)](https://codeclimate.com/github/r7kamura/rack-oauth_proxy)

Delegates OAuth authentication to other authentication server.

## Usage
For Rails example:

```ruby
class BlogsController < ApplicationController
  use Rack::OauthProxy, url: "http://auth.example.com/oauth/token"

  before_action :require_authorization

  def show
    ...
  end

  private

  def require_authorization
    raise UnauthorizedError unless has_authorization?
  end

  # env["rack-oauth_proxy.resopnse"] is a Faraday::Response object.
  def has_authorization?
    env["rack-oauth_proxy.resopnse"].status == 200
  end
end
```
