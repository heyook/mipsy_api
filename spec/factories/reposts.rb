# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :repost do
    article
    user
    ref_id "234"
    ref_type "weibo"
  end
end
