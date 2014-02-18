# Rack::OauthProxy
Delegates OAuth authentication to other authentication server.

## Usage
For Rails example:

```ruby
class ApplicationController < ActionController::Base
  use Rack::OauthProxy, url: "http://auth.example.com/oauth/token"
end
```
