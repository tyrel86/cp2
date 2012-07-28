# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
	
	factory :user_profile do
		first_name { Faker::Name.first_name }
		last_name  { Faker::Name.last_name }
		birth_day  { Date.today - (Random.rand(18..40)).years - (Random.rand(1..11)).months - (Random.rand(1..27)).days }
		gender     { Random.rand(0..1) == 0 ? true : false }
		favorite_strains { Faker::Lorem.words( 7 ).join( ", " ) }	
	end

end
