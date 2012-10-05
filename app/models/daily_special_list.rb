class DailySpecialList < ActiveRecord::Base
  attr_accessible :dispensary_id, :fr, :mo, :sa, :su, :th, :tu, :we, :week

	belongs_to :dispensary
end
