# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    title "MyString"
    body "MyText"
    order 1
  end
end
