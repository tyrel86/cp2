# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dispensary do
		name { Faker::Company.name }
		street_address { Faker::Address.street_address }
		zip_code "80021"
		state "CO"
		city "Denver"
		featured false
		phone_number do
			area_code = Random.rand(0..1) == 0 ? "303" : "720"
			dig3 = ""
			3.times { dig3 += Random.rand(0..9).to_s }
			dig4 = ""
			4.times { dig4 += Random.rand(0..9).to_s }
			"#{area_code}-#{dig3}-#{dig4}"
		end
		glass_sale    { Random.rand(0..1) == 0 ? false : true }
		whole_sale    { Random.rand(0..1) == 0 ? false : true }
		match_coupons { Random.rand(0..1) == 0 ? false : true }
  end
end
