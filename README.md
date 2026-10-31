# Rack::OauthProxy [![Build Status](https://travis-ci.org/r7kamura/rack-oauth_proxy.png)](https://travis-ci.org/r7kamura/rack-oauth_proxy) [![Code Climate](https://codeclimate.com/github/r7kamura/rack-oauth_proxy.png)](https://codeclimate.com/github/r7kamura/rack-oauth_proxy) [![Code Climate](https://codeclimate.com/github/r7kamura/rack-oauth_proxy/coverage.png)](https://codeclimate.com/github/r7kamura/rack-oauth_proxy)

> [!NOTE]
> This project is archived because I no longer actively use it, and there seems to be no recent activity from other users either. If you are still using it and would like to take over maintenance, please contact me somewhere.

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

  # env["rack-oauth_proxy.response"] is a Faraday::Response object.
  def has_authorization?
    env["rack-oauth_proxy.response"].status == 200
  end
end
```
