class Strain < ActiveRecord::Base
	attr_protected
	has_one :strain_wiki
	has_one :strain_review

	name_reg = /\A([a-z0-9\-\'\#]+\s?)*\z/i

	validates_format_of :name, with: name_reg

	def review( uid, r_couch_lock, r_creativity )
		if self.strain_review.nil?
			self.strain_review = StrainReview.create( strain_id: self.id )
			UserStrainReview.create( user_id: uid, strain_id: self.id,
																		couch_lock: r_couch_lock, creativity: r_creativity )
		else
			usr = UserStrainReview.where( user_id: uid, strain_id: self.id ).first
			if usr.nil?
				UserStrainReview.create( user_id: uid, strain_id: self.id, couch_lock: r_couch_lock, creativity: r_creativity )
			else
				usr.update_attributes( user_id: uid, strain_id: self.id, couch_lock: r_couch_lock, creativity: r_creativity )
			end
		end
		self.strain_review.update_review_values
	end

	def get_wiki_proposals
		UserStrainWiki.where( strain_id: self.id )
	end

	def update_wiki( wiki_proposal, sections = nil )
		wiki = self.strain_wiki
		wiki ||= StrainWiki.create
		
		#Update all sections if none are specified from method call
		sections = [:flavors, :effect, :health_benefits, :sativa_indica, :ideal_growing_conditions, :origin] unless sections
		
		#Update all attributes specifed in the sections array from wiki_proposal to wiki
		sections.each do |section|
			eval "wiki.#{section} = wiki_proposal.#{section}"
		end
		#and save
		wiki.save
	end

end
