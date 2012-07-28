require 'spec_helper'

describe DispensaryComment do

	it "Should desern user and dispensary when created from user method" do
		user = FactoryGirl.create :user
		dispensary = FactoryGirl.create :dispensary
		user.should respond_to :write_dispensary_comment
		user.write_dispensary_comment dispensary, Faker::Lorem.paragraph(5)
		dispensary.dispensary_comments.first.id.should equal user.dispensary_comments.first.id
	end

end
