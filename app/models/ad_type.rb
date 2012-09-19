class AdType < ActiveRecord::Base
  attr_accessible :height, :name, :width

	has_many :ad
end
