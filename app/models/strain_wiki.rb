class StrainWiki < ActiveRecord::Base
  attr_protected

	belongs_to :strain
	
end
