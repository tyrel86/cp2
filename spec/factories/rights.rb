# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :right do
    resource "MyString"
    operation "MyString"
  end
end
