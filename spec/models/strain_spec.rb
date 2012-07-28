require 'spec_helper'

describe Strain do

	it "Should have a working facotory" do
		FactoryGirl.build(:strain).should be_valid
	end

	it "Should have a review actions" do
		s = FactoryGirl.create :strain
		s.should respond_to :review
	end

	it "Should create a dispensary review if it is the first one" do
		u = FactoryGirl.create :user
		s = FactoryGirl.create :strain
		s.strain_review.should be_nil
		s = FactoryGirl.create :strain
		s.review u.id, 8, 8
		s.strain_review.should_not be_nil
		s.strain_review.couch_lock.should eq 8
		s.strain_review.creativity.should eq 8
	end

	it "Should update review with new average and create a new user strain review if the user has not reviewd that strain" do
		s = FactoryGirl.create :strain
		u = FactoryGirl.create :user, user_name: "Bmigeee67", email: "bmigee8@gmail.com"
		s.review u.id, 8, 8
		u2 = FactoryGirl.create :user, user_name: "Bmigeee69", email: "bmigee89@gmail.com"
		s.review u2.id, 10, 10
		s.strain_review.couch_lock.should eq 9
		s.strain_review.creativity.should eq 9
	end
	
	it "Should update averages properly if user has already reviewd dispensary by acounting for old and new user_strain_reviews" do
		s = FactoryGirl.create :strain
		u = FactoryGirl.create :user, user_name: "Bmigeee67", email: "bmigee8@gmail.com"
		u2 = FactoryGirl.create :user, user_name: "Bhksid", email: "bjdkskl@gmail.com"
		s.review u.id, 4, 4
		s.review u2.id, 10, 10
		s.review u.id, 8, 8
		s.strain_review.couch_lock.should eq 9
		s.strain_review.creativity.should eq 9
	end

	it "Should allow you to get all releated wiki proposals" do
		u = FactoryGirl.create :user
		s = FactoryGirl.create :strain
		swp = FactoryGirl.create :user_strain_wiki
		swp.strain_id = s.id
		swp.save
		swp2 = FactoryGirl.create :user_strain_wiki
		swp2.strain_id = s.id
		swp2.save
		proposal_array = s.get_wiki_proposals
		proposal_array.size.should eq 2
		proposal_array.each do |proposal|
			proposal.strain_id.should eq s.id
		end
	end

	it "Should create a new wiki if one does not exist yet" do
		u1 = FactoryGirl.create :user
		s = FactoryGirl.create :strain
		
		swp1 = FactoryGirl.create :user_strain_wiki
		swp1.strain_id = s.id
		swp1.user_id = u1.id
		swp1.save
		swp1.should_not be_nil

		s.strain_wiki.should be_nil, "#{StrainWiki.where strain_id: s.id}"
		s.update_wiki swp1
		s.strain_wiki.should_not be_nil
		s.strain_wiki.flavors.should eq swp1.flavors
	end
	
	it "Should have a comand to update its wiki based on a section or sections from a wiki proposal" do
		u1 = FactoryGirl.create :user
		u2 = FactoryGirl.create :user
		s = FactoryGirl.create :strain
		
		swp1 = FactoryGirl.create :user_strain_wiki
		swp1.strain_id = s.id
		swp1.user_id = u1.id
		swp1.save

		swp2 = FactoryGirl.create :user_strain_wiki
		swp2.strain_id = s.id
		swp2.user_id = u2.id
		swp2.save

		s.update_wiki swp1, [:flavors]
		s.strain_wiki.flavors.should eq swp1.flavors
		s.update_wiki swp2, [:effect, :origin]
		s.strain_wiki.flavors.should eq swp1.flavors
		s.strain_wiki.effect.should  eq swp2.effect
		s.strain_wiki.origin.should  eq swp2.origin
	end

end
