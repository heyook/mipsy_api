require 'rails_helper'

describe WeiboRepost do

  let(:article)   { create(:article) }
  let(:user)      { create(:user)    }
  let!(:identity) { create(:identity, identifiable: user, access_token: "token")}
  let(:raw_info)  { JSON.parse(File.read(fixture_file("repost.json"))) }
  let(:api)       { double(repost: raw_info) }
  let(:params)    { {title: "hello", article_id: article.id} }

  describe "Create" do

    let(:repost) { WeiboRepost.(user, params).resource }

    before do
      expect(WeiboApi).to receive(:new).and_return api
    end

    it "create the repost" do
      expect(repost).to be_kind_of(Repost)
    end

    it "saves article ref" do
      expect(repost.article).to eq(article)
    end

    it "saves refs" do
      expect(repost.ref_id).to eq("3813342785470391")
      expect(repost.ref_type).to eq("weibo")
    end

    it "saves info" do
      expect(repost.info).to_not be_nil
      expect(repost.info["reposts_count"]).to eq(0)
    end

  end

  describe "Error" do
    let(:invalid_repost) { WeiboRepost.(user, params).resource }

    before do
      identity.access_token = nil
      identity.save

      expect(WeiboApi).to_not receive(:new)
    end

    it "returns error" do
      expect(invalid_repost.errors).to_not be_blank
    end
  end

end
