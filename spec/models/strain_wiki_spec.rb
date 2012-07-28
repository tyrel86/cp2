require 'spec_helper'

describe StrainWiki do

	it "Should have a working factory" do
		FactoryGirl.create(:strain_wiki).should be_valid
	end

	it "Should be able to swap out sections from different user strain wikis" do
		
	end

end
