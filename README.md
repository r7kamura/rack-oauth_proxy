# Rack::OauthProxy [![Build Status](https://travis-ci.org/r7kamura/rack-oauth_proxy.png)](https://travis-ci.org/r7kamura/rack-oauth_proxy) [![Code Climate](https://codeclimate.com/github/r7kamura/rack-oauth_proxy.png)](https://codeclimate.com/github/r7kamura/rack-oauth_proxy) [![Code Climate](https://codeclimate.com/github/r7kamura/rack-oauth_proxy/coverage.png)](https://codeclimate.com/github/r7kamura/rack-oauth_proxy)

Delegates OAuth authentication to other authentication server.

## Usage
For Rails example:

```ruby
class ApplicationController < ActionController::Base
  use Rack::OauthProxy, url: "http://auth.example.com/oauth/token"
end
```
