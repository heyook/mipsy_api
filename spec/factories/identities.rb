# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    uid "789"
    provider 'weibo'
    info({})
  end
end
