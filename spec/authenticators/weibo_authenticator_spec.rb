require 'rails_helper'

describe WeiboAuthenticator do

  let(:access_token)  { double( params:{"uid"=> "abc"}, token: "token") }
  let(:raw_info)      { JSON.parse(File.read(fixture_file("user.json"))) }
  let(:authenticator) { WeiboAuthenticator.new("abc") }

  before do
    expect(authenticator).to receive(:access_token).at_least(1).times \
      .and_return access_token
    expect(authenticator).to receive(:raw_info).at_least(1).times \
      .and_return raw_info
  end

  describe "User Info" do

    let(:info) { authenticator.oauth_info }

    it "returns basic info" do
      #from access_token.params["uid"]
      expect(info[:uid]).to eq("abc")
      expect(info[:provider]).to eq("weibo")
      expect(info[:access_token]).to eq("token")
    end

    it "returns all info" do
      expect(info[:info][:nickname]).to eq("zaku")
    end

  end

end
