class HoursOfOperation < ActiveRecord::Base
  # attr_protected :fr_end, :fr_start, :mo_end, :mo_start, :sa_end, :sa_start, :su_end, :su_start, :th_end, :th_start, :tu_end, :tu_start, :we_end, :we_start
	
	attr_protected :dispensary_id

	belongs_to :dispensary

	def attr_as_formated_string( atr )
		if self.respond_to? atr
			string = self.send( atr ).strftime( "%I:%M %p" )
		end
		string ? string : "Not Set"
	end

end
