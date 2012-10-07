class Dispensary < ActiveRecord::Base
#####   Globals

	@@good_array = []

##### Acsessors getters and protection for attributes

  attr_accessible :name, :street_address, :city, :state, :zip_code, :phone_number, :glass_sale, 
                           :whole_sale, :match_coupons, :photo, :business_type, :twitter, :facebook

	attr_accessor :distance

######   Relations
	has_many :dispensary_comments
	has_many :critiques
	has_one :dispensary_review
	has_one :hours_of_operation
	has_one :daily_special_list
	has_many :user_dispensary_reviews
  belongs_to :user
	has_attached_file :photo, :styles => { :large => "250x225#", :small => "150x150#" }
	
#######    Filters and call backs	
	before_save :get_lat_lng_from_address


######  Regular Expressions
	address_reg = /^([[:alnum:]\&\-\/\.\'\#[0-9]]+ ?)*$/i
	zip_reg = /^\d{5}([\-]\d{4})?$/
	phone_reg = /^([0-9]( |-)?)?(\(?[0-9]{3}\)?|[0-9]{3})( |-)?([0-9]{3}( |-)?[0-9]{4}|[a-zA-Z0-9]{7})$/

#######  Validations
	validates_format_of :zip_code, with: zip_reg
	validates_format_of :phone_number, with: phone_reg
	validates_presence_of :name, :street_address, :city, :state, :zip_code, :phone_number, :business_type

#######  Data Mappings
		
	def business_type=(input)
	  new_type = case input
			when ( 'Dispensary' )
				1
			when ( 'Grow Store' )
				2
			when ( 'Head Shop' )
				3
			when ( 'Kind Doctor' )
				4
			when ( 'Kind Land Lord' )
				5
			when ( 'Smoke Shop' )
				6
			when ( 'Kind Lawyer' )
				7
			when ( 'Grow Consultant' )
				8
			else
				0
		end
    write_attribute(:business_type, new_type)
  end
  
  def business_type
    bt = read_attribute(:business_type)
    case bt
			when 1
				'Dispensary'
			when 2
				'Grow Store'
			when 3
				'Head Shop'
			when 4
				'Kind Doctor'
			when 5
				'kind Land Lord'
			when 6
				'Smoke Shop'
			when 7
				'Grow Consultant'
			else
				:unclasified
		end
  end

	BUSINESS_TYPE_MAPPINGS = {
		'Dispensary' => 1,
		'Grow Store' => 2,
		'Head Shop' => 3,
		'Kind Doctor' => 4,
		'kind Land Lord' => 5,
		'Smoke Shop' => 6,
		'Grow Consultant' => 7
	}

  def about
    about = read_attribute(:about)
		about ? about : nil_about
	end

	def nil_about
		"#{name} is a #{business_type} located in #{city}, #{state}"
	end

#######  Query Methods

	def self.distance_between( user_location, dispensary )
		distance = DistanceHelper.distance_between  user_location.lat, user_location.lng,
																								dispensary.lat, dispensary.lng, 
																								:mi
		distance.class == String ? distance : distance.round(1)
	end

	def self.next_invalid
		self.all.each do |d|
			next if @@good_array.include? d.id
			if d.valid?
				@@good_array.push d.id
			else
				return d
			end
		end
	end
  
  def self.search( query, cat )
    where do 
			(name =~ "%#{query}%") | (city =~ "%#{query}%") | (zip_code =~ "%#{query}%")
    end
  end

  def self.get_featured( city, cat, amount )
    possible_listings = self.search( city, cat ).where( featured: true ).order( 'dispensaries.featured_shows ASC' ).limit( amount )
  end
  
  
########  Proceedural Methods

	def fix
		tmp_address = self.street_address
		if tmp_address.split(",").size > 1
			a=Geokit::Geocoders::YahooGeocoder.geocode "#{self.street_address} #{self.state}"
		else
			a=Geokit::Geocoders::YahooGeocoder.geocode "#{self.street_address}, #{self.city} #{self.state}"
		end
		self.zip_code = a.zip[0..4]
		(self.destroy and return :destroy) if self.zip_code.empty?
		if tmp_address.empty?
			self.destroy
			return :destroy
		else
			self.street_address = ((tmp_address.split(",").size > 1) ? tmp_address.split(",")[0] : tmp_address)
		end
		tmp_phone = self.phone_number
		(self.destroy and return :destroy) if tmp_phone.empty?
		if tmp_phone.split('.').size > 1
			self.phone_number = tmp_phone.gsub('.','-')
		end
		
		self.phone_number = PhoneNumberWithLetters.translate(self.phone_number)
		self.phone_number = self.phone_number.strip
		if self.valid? 
			self.save
		else
			self.destroy
			return :destroy
		end
	end

	def self.get_all_invalids
		self.all.inject([]) do |r,e|
			e.valid? ? r : r << e
		end
	end

	def full_address
		"#{self.street_address} #{self.city}, #{self.state} #{self.zip_code}"
	end

	def get_lat_lng_from_address
		old_d = self.id.nil? ? nil? : Dispensary.find( self.id )
		if( ( old_d.nil? ) or ( self.lat.nil? ) or ( lng.nil? ) or ( self.street_address != old_d.street_address ) or \
			( self.city != old_d.city ) or ( self.state != old_d.state) or ( self.zip_code != old_d.zip_code ) )
			geo = Geokit::Geocoders::YahooGeocoder.geocode self.full_address
			self.lat = geo.lat
			self.lng = geo.lng
		end
	end

	def self.do_lat_lng_all
		self.all.each do |d|
			d.get_lat_lng_from_address
			sleep(1)
		end
	end

  def map_link
    "http://maps.google.com/?q=#{street_address}, #{city_state_zip}"
  end
  
  def num_of_reviews
    user_dispensary_reviews.size
  end
	
  def safe_photo_url
    photo_url || "http://placekitten.com/150/150"  
  end

	def featured_status
		if expiration < Date.today
			return "<span class='label label-warning'>Expired</span>"
		end
		if featured
			"<span class='label label-success'>Live</span>"
		elsif requrest_featured
			"<span class='label label-info'>Pending payment and aproval</span>"
		else
			"<span class='label label-info'>Not Featured</span>"
		end
	end
 
  def formated_phone_number
    "(#{phone_number[0..2]})-#{phone_number[3..5]}-#{phone_number[6..9]}"
  end

	def review( uid, r_bud_tenders, r_selection, r_atmosphere )
		if self.dispensary_review.nil?
			self.dispensary_review = DispensaryReview.create( dispensary_id: self.id )
			UserDispensaryReview.create( user_id: uid, dispensary_id: self.id,
																		bud_tenders: r_bud_tenders, selection: r_selection,
																 		atmosphere: r_atmosphere )
		else
			udr = UserDispensaryReview.where( user_id: uid, dispensary_id: self.id ).first
			if udr.nil?
				UserDispensaryReview.create( user_id: uid, dispensary_id: self.id,
																			bud_tenders: r_bud_tenders, selection: r_selection,
																			atmosphere: r_atmosphere )
			else
				udr.update_attributes( user_id: uid, dispensary_id: self.id, bud_tenders: r_bud_tenders, 
															selection: r_selection, atmosphere: r_atmosphere )
			end
		end
		self.dispensary_review.update_review_values
	end
  
################### Data Manipulation Methods

	def average_rating
	   r = dispensary_review.average_rating if dispensary_review
	   r ||= 0
	   r
  end

  def short_name
    (name.size > 32) ? "#{name[0..31]}..." : name
  end

  def city_state_zip
    "#{city}, #{state}, #{zip_code}"
  end

################### Getter Setter OVERRIDES

	def glass_sale=(input)
	  glass_sale = ((input == "yes") ? true : false )
    write_attribute(:glass_sale, glass_sale)
  end
  
  def glass_sale
    glass_sale = read_attribute(:gender)
    glass_sale ? "yes" : "no"
  end
  
	def whole_sale=(input)
	  whole_sale = ((input == "yes") ? true : false )
    write_attribute(:whole_sale, whole_sale)
  end
  
  def whole_sale
    whole_sale = read_attribute(:whole_sale)
    whole_sale ? "yes" : "no"
  end

	def match_coupons=(input)
	  match_coupons = ((input == "yes") ? true : false )
    write_attribute(:match_coupons, match_coupons)
  end
  
  def match_coupons
    match_coupons = read_attribute(:match_coupons)
    match_coupons ? "yes" : "no"
  end

	def deals?
		daily? or weekly?
	end

	def daily?
		daily_special_list.today
	end

	def weekly?
		daily_special_list.week
	end

	def daily
		daily? ? daily? : "Sorry none today"
	end

	def weekly
		weekly? ? weekly? : "Sorry none this week"
	end

	def has_social_links?
		return true if (twitter and (not twitter.empty?)) or (facebook and (not facebook.empty?))
		false
	end

	def has_twitter?
		(twitter and (not twitter.empty?)) ? true : false
	end

	def has_facebook?
		(facebook and (not facebook.empty?)) ? true : false
	end

end
