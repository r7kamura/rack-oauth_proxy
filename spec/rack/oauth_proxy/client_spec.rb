require "spec_helper"
require "securerandom"
require "stringio"

describe Rack::OauthProxy::Client do
  before do
    stub_request(:get, url).to_return(status: 401, body: {}.to_json)
    stub_request(:get, url).with(headers: { "Authorization" => "Bearer #{token}" }).to_return(response)
  end

  let(:client) do
    described_class.new(options)
  end

  let(:options) do
    { url: url }
  end

  let(:url) do
    "http://example.com/oauth/token"
  end

  let(:env) do
    {
      "HTTP_AUTHORIZATION" => "Bearer #{token}",
      "HTTP_DUMMY" => "dummy",
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
      it "returns valid access token" do
        client.fetch(env).should be_a Rack::OauthProxy::AccessTokens::Valid
        a_request(:get, url).with(headers: { "Authorization" => "Bearer #{token}" }).should have_been_made
      end
    end

    context "when authentication failed" do
      before do
        env.delete("HTTP_AUTHORIZATION")
      end

      it "returns invalid access token" do
        client.fetch(env).should be_a Rack::OauthProxy::AccessTokens::Invalid
        a_request(:get, url).should have_been_made
      end
    end

    context "with propagated header fields option" do
      before do
        options[:propagated_header_fields] = ["Dummy"]
      end

      it "propagates specified fields" do
        client.fetch(env).should be_a Rack::OauthProxy::AccessTokens::Invalid
        a_request(:get, url).with(headers: { "DUMMY" => "dummy" }).should have_been_made
      end
    end
  end
end
