namespace :database do

	desc "Drops development database and recreates schema"
	task clear: :environment do
		Rake::Task["db:drop"].execute
		Rake::Task["db:create"].execute
		Rake::Task["db:schema:load"].execute
	end

	desc "Repopulates database with factory girl objects"
	task populate: :environment do
		require 'rubygems'
		100.times do
			u = FactoryGirl.create(:user)
			up = FactoryGirl.create(:user_profile)
			u.user_profile = up
		end
		user_array = User.all
		20.times do
			d = FactoryGirl.create :dispensary
			3.times do
				body_for_review = Faker::Lorem.paragraph 5
				user_array[Random.rand(0..(user_array.size - 1))].write_dispensary_comment(d, body_for_review)
			end
			3.times do |i|
				d.review user_array.sample.id, Random.rand(1..10), Random.rand(1..10), Random.rand(1..10)
			end
		end
		10.times do
			s = FactoryGirl.create :strain
			swp_array = []
			3.times do
				swp_array.push FactoryGirl.create(:user_strain_wiki, user_id: user_array.sample, strain_id: s.id )
			end
			s.update_wiki swp_array.sample
			3.times do
				s.review user_array.sample.id, Random.rand(1..10), Random.rand(1..10)
			end
		end
	end

	desc "Recreates test database schema"
	task clear_test: :environment do
		ActiveRecord::Base.establish_connection("test")
		Rake::Task["db:schema:load"].execute
	end

  desc "Update both test and development from schema.rb"
  task update_schema: :environment do
    ActiveRecord::Base.establish_connection("development")
    Rake::Task["db:schema:load"].execute
		ActiveRecord::Base.establish_connection("test")
		Rake::Task["db:schema:load"].execute
	end
	
	desc "Resets database to testing state based on schema.rb and factorie girl files"
	task reset: [:clear, :populate, :clear_test]

end
