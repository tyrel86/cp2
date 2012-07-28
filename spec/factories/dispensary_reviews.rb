# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dispensary_review do
		bud_tenders { Random.rand(1..10) }
		selection   { Random.rand(1..10) }
		atmosphere  { Random.rand(1..10) }
  end
end
