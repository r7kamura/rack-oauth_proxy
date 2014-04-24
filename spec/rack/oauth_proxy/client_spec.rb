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

  let(:response) do
    {
      status: status,
      body: body,
    }
  end

  let(:status) do
    200
  end

  let(:body) do
    {}.to_json
  end

  context "#fetch" do
    context "when authentication succeeded" do
      before do
        stub_request(:get, url).to_return(response)
      end

      it "returns valid access token" do
        client.fetch(env).should be_a Rack::OauthProxy::AccessTokens::Valid
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
