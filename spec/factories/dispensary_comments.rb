# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
	factory :dispensary_comment do
		body { Faker::Lorem.paragraph 5 }
  end

end
