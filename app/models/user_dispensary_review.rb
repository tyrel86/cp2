class UserDispensaryReview < ActiveRecord::Base
 	attr_protected
	
  belongs_to :dispensary  

	def get_review_as_hash
		{ bud_tenders: self.bud_tenders, selection: self.selection, atmosphere: self.atmosphere }
	end

end
