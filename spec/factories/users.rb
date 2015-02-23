# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email
    password 'secretpwd'
    confirmed_at { Time.now.utc }

    factory :unconfirmed_user do
      confirmed_at nil
    end
  end
end
