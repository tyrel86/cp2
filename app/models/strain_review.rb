class StrainReview < ActiveRecord::Base
  attr_protected

	belongs_to :strain

	def update_review_values
		udra = UserStrainReview.where( strain_id: self.strain_id ).all #Array of UserStrainReviews
		
		couch_lock_total = udra.inject(0) do |r,e|
			e.couch_lock + r
		end

		creativity_total = udra.inject(0) do |r,e|
			e.creativity + r
		end
		
		num_of_reviews = udra.size

		self.couch_lock = ( couch_lock_total.to_f / num_of_reviews ).round(1)
		self.creativity = ( creativity_total.to_f / num_of_reviews ).round(1)
		self.save
	end	

end
