# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "my post"
    link "http://hero.x"
    image_url "http://hero.image"
    ref_id "123"
    ref_type "weibo"
  end
end
