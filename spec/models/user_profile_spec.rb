require 'spec_helper'

# up stands for user_profile

describe UserProfile do

	before { @user_profile = FactoryGirl.build :user_profile }

	it "Should protect id and user_id from mass asignment" do
		@user_profile['id'] = 42
		@user_profile['id'] = 42
		@user_profile.save
	end

	it "A basic factory should be valid" do
		@user_profile.should be_valid
	end

	it "Should only except names with no spaces" do
		up = FactoryGirl.build :user_profile, first_name: "Helen a"
		up.should be_invalid
		up = FactoryGirl.build :user_profile, last_name:  "Helen a"
		up.should be_invalid
	end

	it "Should acsept names with apostrophies" do
		up = FactoryGirl.build :user_profile, first_name: "O'Donnell"
		up.should be_valid
		up = FactoryGirl.build :user_profile, last_name: "O'Donnell"
		up.should be_valid
	end

	it "Should reject names with other special characters" do
		up = FactoryGirl.build :user_profile, first_name: "Max&"
		up.should be_invalid
		up = FactoryGirl.build :user_profile, last_name: "Max*"
		up.should be_invalid
	end

	it "Should resond to age with an integer value" do
		@user_profile.age.class.should eq( Fixnum )
	end
  
	it "Should return an integer for age based on their birthday" do
		now = Time.now.utc.to_date
		dob = @user_profile.birth_day
		birthday_from_algorithm = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
		@user_profile.age.should eq( birthday_from_algorithm  )
	end

	it "Should only acept dates for birth_date" do
		up = FactoryGirl.build :user_profile, birth_day: "mybirthday"
		up.should be_invalid
	end

	it "Should have method get_gender_as_symbol and should return :male on true and :female on false" do
		up = FactoryGirl.build :user_profile, gender: false
		up.get_gender_as_symbol.should eq( :female )
	end

	it "Should have method get_gender_as_string and should return respectivly 'female' and 'male'" do
		up = FactoryGirl.build :user_profile, gender: true
		up.get_gender_as_string.should eq( "male" )
	end

	it "Favorite strains should be linked to wiki and insure proper formating for tags" do
		pending "Get data from seed finder"
		pending "Create proper relation model for favorite_strains"
		pending "Insure validations"
	end
	
end
