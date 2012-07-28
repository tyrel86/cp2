require 'spec_helper'

describe UserStrainWiki do

	it "Should have a working factory" do
		FactoryGirl.build(:user_strain_wiki).should be_valid
	end


end
