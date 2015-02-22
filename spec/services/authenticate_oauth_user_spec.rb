require 'rails_helper'

describe AuthenticateOauthUser do

  let(:oauth_info) { {
    provider: "weibo",
    uid: "user1",
    access_token: "token",
    info: {
      nickname: "he9qi",
      name: "He Qi",
      location: 'US',
      image: "http://weibo.com/image",
      description: "desc"
    } } }
  let(:authenticator) { double(oauth_info: oauth_info) }
  let(:oauth_params)  { {code: "abc", provider: "weibo"} }

  before do
    expect(WeiboAuthenticator).to receive(:new).and_return(authenticator)
  end

  describe "User Oauth Authenticate" do

    let(:user) { AuthenticateOauthUser.({code: "abc", provider: "weibo"}).resource }

    it "renew the key" do
      expect { user }.to change { ApiKey.count }
    end

    it "create a user" do
      expect(user).to_not be_nil
      expect(user).to be_kind_of(User)
    end

    it "update access token" do
      identity = user.identities.find_by provider: "weibo"
      expect(identity.access_token).to eq("token")
    end

  end

end
