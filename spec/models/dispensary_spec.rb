require 'spec_helper'

describe Dispensary do

	before { @dispensary = FactoryGirl.build :dispensary }

	it "Should have a working factory to test" do
		@dispensary.should be_valid, @dispensary.errors.messages
	end

	it "Should only except letters ' - for name" do
		disp = FactoryGirl.build :dispensary, name: "Some wi*rd comapany name"
		disp.should be_invalid
		disp = FactoryGirl.build :dispensary, name: "Hevel-O'Donnell weed dealer"
		disp.should be_valid
	end

	it "Should reject bad street adresses" do
		disp = FactoryGirl.build :dispensary, street_address: "12345 Fak*e st."
		disp.should be_invalid
	end

	it "Should auto populate city and state base on zip code on save" do
		@dispensary.zip_code = "80003"
		@dispensary.city.should be_nil
		@dispensary.state.should be_nil
		@dispensary.save
		@dispensary.city.should eq "Arvada"
		@dispensary.state.should eq "CO"
	end

	it "Should reject bad zip codes goodExamples: 12345-1234 or 12345" do
		disp = FactoryGirl.build :dispensary, zip_code: "1234567"
		disp.should be_invalid
	end

	it "Should reject bad phone numbers good expample 303-123-1234" do
		disp = FactoryGirl.build :dispensary, phone_number: "(303)456-7890"
		disp.should be_invalid
	end

	it "Should not allow ID to be mass assigned" do
			attributes = @dispensary.attributes
			attributes['id'] = 42	
			lambda do
				@dispensary.update_attributes( attributes )
			end.should raise_error ActiveModel::MassAssignmentSecurity::Error
	end

	it "Should allow all other attributes to be mass assigned save for time stamps" do
			attributes = @dispensary.attributes
			attributes.delete 'created_at'
			attributes.delete 'updated_at'
			attributes.delete 'id'
		 	attributes['name'] = "Yo"	
			@dispensary.update_attributes attributes
			@dispensary.name.should eq "Yo"
	end

	it "Should respond to review function" do
		@dispensary.should respond_to :review
	end

	it "Should create a dispensary review if it is the first one" do
		d = FactoryGirl.create :dispensary
		d.dispensary_review.should be_nil
		u = FactoryGirl.create :user, user_name: "Bmigeee67", email: "bmigee8@gmail.com"
		d.review u.id, 8, 8, 8
		d.dispensary_review.should_not be_nil
	end

	it "Should update review with new average and create a new user dispensary review if the user has not reviewd that dispensary" do
		d = FactoryGirl.create :dispensary
		u = FactoryGirl.create :user, user_name: "Bmigeee67", email: "bmigee8@gmail.com"
		d.review u.id, 8, 8, 8
		u2 = FactoryGirl.create :user, user_name: "Bmigeee69", email: "bmigee89@gmail.com"
		d.review u2.id, 10, 10, 10
		d.dispensary_review.bud_tenders.should eq 9
		d.dispensary_review.selection.should eq 9
		d.dispensary_review.atmosphere.should eq 9
	end
	
	it "Should update averages properly if user has already reviewd dispensary by acounting for old and new" do
		d = FactoryGirl.create :dispensary
		u = FactoryGirl.create :user, user_name: "Bmigeee67", email: "bmigee8@gmail.com"
		u2 = FactoryGirl.create :user, user_name: "Bhksid", email: "bjdkskl@gmail.com"
		d.review u.id, 4, 4, 4
		d.review u2.id, 10, 10, 10
		d.review u.id, 8, 8, 8
		d.dispensary_review.bud_tenders.should eq 9
		d.dispensary_review.selection.should eq 9
		d.dispensary_review.atmosphere.should eq 9
	end
end
