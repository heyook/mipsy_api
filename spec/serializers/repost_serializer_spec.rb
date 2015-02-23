require 'rails_helper'

describe RepostSerializer do

  let(:article)    { create(:article) }
  let(:info) {
    { "reposts_count" => 0,
    "comments_count" => 1,
    "attitudes_count" => 2 }
  }
  let(:repost)  { create(:repost, article: article, info: info) }
  let(:json)    { JSON.parse(described_class.new(repost).to_json) }

  it 'returns article id' do
    expect(json["repost"]["article_id"]).to eq(article.id)
  end

  it 'returns info' do
    expect(json["repost"]["reposts_count"]).to eq(0)
    expect(json["repost"]["comments_count"]).to eq(1)
    expect(json["repost"]["attitudes_count"]).to eq(2)
  end

end
