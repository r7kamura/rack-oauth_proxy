require "spec_helper"
require "stringio"

describe Rack::OauthProxy::Client do
  let(:client) do
    described_class.new(url: url)
  end

  let(:url) do
    "http://example.com/oauth/token"
  end

  let(:env) do
    {
      "HTTP_AUTHORIZATION" => "Bearer #{token}",
      "rack.input" => StringIO.new,
    }
  end

  let(:token) do
    SecureRandom.hex(32)
  end

  context "#fetch" do
    context "when authentication succeeded" do
      before do
        stub_request(:get, url).to_return(status: 200, body: {}.to_json)
      end

      it "returns valid access token" do
        client.fetch(env).should be_a Rack::OauthProxy::AccessTokens::Valid
      end
    end

    context "without no credentials in request" do
      before do
        env.delete("HTTP_AUTHORIZATION")
      end

      it "returns invalid access token" do
        client.fetch(env).should be_a Rack::OauthProxy::AccessTokens::Invalid
      end
    end

    context "when authentication failed" do
      before do
        stub_request(:get, url).to_return(status: 401, body: {}.to_json)
      end

      it "returns invalid access token" do
        client.fetch(env).should be_a Rack::OauthProxy::AccessTokens::Invalid
      end
    end
  end
end
