class DailySpecialList < ActiveRecord::Base
  attr_accessible :dispensary_id, :fr, :mo, :sa, :su, :th, :tu, :we, :week

	belongs_to :dispensary

	def today
		self.send( Date.today.strftime( "%a" ).downcase[0..1] )
	end

end
