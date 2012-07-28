require 'spec_helper'

describe User do
	before { @user = FactoryGirl.build :user }

	it "Should protect id from mass assignment" do
		attributes = @user.attributes
		attributes['id'] = 42
		lambda do
			User.create(attributes).id.should_not equal 42
		end.should raise_error ActiveModel::MassAssignmentSecurity::Error
	end

	it "A basic factory should be valid" do
		@user.should be_valid
	end

	it "Should acsept all letters numbers . - _ for user_name" do
		user = FactoryGirl.build :user, user_name: "aB1-_."
		user.should be_valid
	end

	it "Should reject user names with spaces" do
		user = FactoryGirl.build :user, user_name: "the dude"
		user.should be_invalid
	end

	it "Should reject user names with special characters other than - _ ." do
		user = FactoryGirl.build :user, user_name: "the*dude"
		user.should be_invalid
	end

	it "Should reject user names under 5 characters" do
		user = FactoryGirl.build :user, user_name: "abcd"
		user.should be_invalid
	end

	it "Should reject user names over 15 characters" do
		user = FactoryGirl.build :user, user_name: "1234567890123456"
		user.should be_invalid
	end

	it "Should reject user if all required fields are not filled out (user_name, email, password, passowrd_confirmation)" do
		required_attrs = [ :user_name, :email, :password, :password_confirmation ]
		required_attrs.each do |attr|
			user = FactoryGirl.build :user, attr => nil
			user.should be_invalid
		end
	end

	it "Should insure uniqueness of user_name" do
		user1 = FactoryGirl.create :user, user_name: "thedude"
		user2 = FactoryGirl.build :user, user_name: "thedude"
		user2.should be_invalid
	end

	it "Should reject syntacticaly incorect email addresses" do
		user = FactoryGirl.build :user, email: "8In@ bloob.com" 
		user.should be_invalid
	end

	it "Should insure uniquness of email" do
		user1 = FactoryGirl.create :user, email: "thedude@gmail.com"
		user2 = FactoryGirl.build :user, email: "thedude@gmail.com"
		user2.should be_invalid
	end

	it "Should reject passwords not between 8 and 20 charachters" do
		user1 = FactoryGirl.build :user, password: "1234567", password_confirmation: "1234567"
		user2 = FactoryGirl.build :user, password: "123456789012345678901", password_confirmation: "123456789012345678901"
		user1.should be_invalid
		user2.should be_invalid
	end

	it "Should reject passwords with spaces" do
		user = FactoryGirl.build :user, password: "12345678 a", password_confirmation: "12345678 a"
		user.should be_invalid
	end

	it "Should insure that password and password_confirmation are the same" do
		user = FactoryGirl.build :user, password: "12345678", password_confirmation: "12345677"
		user.should be_invalid
	end

	it "Should be able to be asigned to a user_profile and should be able to retriev values like first_name" do
		up = FactoryGirl.build :user_profile
		@user.user_profile = up
		@user.user_profile.first_name.should eq up.first_name
	end

	it "Should have a function create_wiki_proposal" do
		user = FactoryGirl.create(:user)
		User.find(user.id).should_not be_nil
		user.should respond_to :create_wiki_proposal
	end

	it "Should create a new user_strain_wiki when create_wiki_proposal is called if one does not exist" do
		user = FactoryGirl.create(:user)
		User.find(user.id).should_not be_nil

		strain = FactoryGirl.create(:strain)
		Strain.find(strain.id).should_not be_nil

		usw = UserStrainWiki.where( user_id: user.id, strain_id: strain.id ).first
		usw.should be_nil

		sw = FactoryGirl.create(:strain_wiki)
		user.create_wiki_proposal( strain.id, sw.flavors, sw.effect, sw.health_benefits, sw.sativa_indica, sw.ideal_growing_conditions, sw.origin )
		
		usw = UserStrainWiki.where( user_id: user.id, strain_id: strain.id ).first
		usw.should_not be_nil
	end

	it "Should have a function to return its wiki proposal for a particular strain or nil" do
		@user.should respond_to :get_wiki
		user = FactoryGirl.create :user
		strain = FactoryGirl.create :strain
		sw = FactoryGirl.create :strain_wiki

		user.create_wiki_proposal( strain.id, sw.flavors, sw.effect, sw.health_benefits, sw.sativa_indica, sw.ideal_growing_conditions, sw.origin )
		user_proposal = user.get_wiki strain.id
		user_proposal.flavors.should eq sw.flavors
	
		user2 = FactoryGirl.create :user	
		user2_proposal = user2.get_wiki strain.id
		user2_proposal.should be_nil
	end

	it "Should update a previews wiki proposal if create_wiki_proposal is called and one already exists for that wiki" do
		user = FactoryGirl.create :user
		User.find( user.id ).should_not be_nil

		strain = FactoryGirl.create :strain
		Strain.find( strain.id ).should_not be_nil

		sw1 = FactoryGirl.create :strain_wiki
		user.create_wiki_proposal( strain.id, sw1.flavors, sw1.effect, sw1.health_benefits, sw1.sativa_indica, sw1.ideal_growing_conditions, sw1.origin )
		swp = user.get_wiki strain.id
		swp.effect.should eq sw1.effect

		sw2 = FactoryGirl.create :strain_wiki
		user.create_wiki_proposal( strain.id, sw2.flavors, sw2.effect, sw2.health_benefits, sw2.sativa_indica, sw2.ideal_growing_conditions, sw2.origin )
		swp = user.get_wiki strain.id
		swp.effect.should eq sw2.effect
	end	

end
