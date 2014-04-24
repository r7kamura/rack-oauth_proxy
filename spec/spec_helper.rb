require "simplecov"
SimpleCov.start

require "webmock/rspec"

if ENV["CI"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
  WebMock.allow_net_connect!
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "rack/oauth_proxy"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end
