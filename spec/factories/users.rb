# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
		sequence(:user_name) {|n| "user#{n}" }
		sequence(:email) {|n| "user#{n}@gmail.com" }
    password "12345678"
		password_confirmation { password }
		association :user_profile, factory: :user_profile
  end
end
