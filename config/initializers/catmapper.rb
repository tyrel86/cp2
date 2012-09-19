module CatHelper

	def self.transformSingle( string )
		case string
			when "Dispensaries"
				'Dispensary'
			when "Grow Stores"
				'Grow Store'
			when "Head Shops"
				'Head Shop'
			when "Kind Doctors"
				'Kind Doctor'
			when "Kind Land Lords"
				'kind Land Lord'
			when 'Smoke Shops'
				'Smoke Shop'
			when 'kind Lawyers'
				'kind Lawyer'
			when 'Grow Consultants'
				'Grow Consultant'
			else
				:all
		end
	end
	
	def self.transformPlural( string )
		case string
			when :all
				"All Categories"
			when 'Dispensary'
				'Dispensaries'
			when "Grow Store"
				'Grow Stores'
			when "Head Shop"
				'Head Shops'
			when "Kind Doctor"
				'Kind Doctors'
			when "kind Land Lord"
				'kind Land Lords'
			when 'Smoke Shop'
				'Smoke Shops'
			when 'Kind Lawyer'
				'kind Lawyers'
			when 'Grow Consultant'
				'Grow Consultants'
			else
				:all
		end
	end

end
