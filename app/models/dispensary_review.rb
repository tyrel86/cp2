class DispensaryReview < ActiveRecord::Base
  
	attr_protected

	belongs_to :dispensary

	def update_review_values
		udra = UserDispensaryReview.where( dispensary_id: self.dispensary_id ).all
		
		bud_tenders_total = udra.inject(0) do |r,e|
			e.bud_tenders + r
		end
		selection_total = udra.inject(0) do |r,e|
			e.selection + r
		end
		atmosphere_total = udra.inject(0) do |r,e|
			e.atmosphere + r
		end
		
		num_of_reviews = udra.size

		self.bud_tenders = ( bud_tenders_total.to_f / num_of_reviews ).round(1)
		self.selection = ( selection_total.to_f / num_of_reviews ).round(1)
		self.atmosphere = ( atmosphere_total.to_f / num_of_reviews ).round(1)
		self.save
	end
	
	def average_rating
    (((bud_tenders + selection + atmosphere) / 3)/2).to_i
  end

end
