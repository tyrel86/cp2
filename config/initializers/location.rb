class UserLocation

	attr_accessor :lat, :lng

  def initialize(lat, lng)
    @lat, @lng = lat, lng
  end

	def self.new_from_ip( ip )
		l = Geokit::Geocoders::IpGeocoder.geocode( ip )
		self.new( l.lat, l.lng )
	end

end
