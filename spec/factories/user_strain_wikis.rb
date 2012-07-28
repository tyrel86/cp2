#Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_strain_wiki do
		flavors { Faker::Lorem.words(5).join(', ') + "and #{Faker::Lorem.words(1).first}" }
		effect { Faker::Lorem.sentences(5).join(' ') }
		health_benefits { Faker::Lorem.sentences(5).join(' ') }
		sativa_indica do
			ones = Random.rand(0..100).to_s
			if ones == "100"
				decims = "00"
			else
				decims = Random.rand(0..99).to_s
			end
			(ones + "." + decims).to_f
		end
		ideal_growing_conditions { Faker::Lorem.sentences(5).join(' ') }
		origin { Faker::Address.city }
  end
end
