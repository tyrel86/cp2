class UserStrainWiki < ActiveRecord::Base
	attr_accessible :flavors, :effect, :health_benefits, :sativa_indica, :ideal_growing_conditions, :origin
end
