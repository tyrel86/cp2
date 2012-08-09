class Dispensary < ActiveRecord::Base
  attr_accessible :name, :street_address, :city, :state, :zip_code, :phone_number, :glass_sale, 
                           :whole_sale, :match_coupons

######   Relations
	has_many :dispensary_comments
	has_one :dispensary_review
  belongs_to :user
	
#######    Filters and call backs	

######  Regular Expressions
	name_reg = /^([[:alnum:]\-\_\'\,]+ ?)*$/i
	address_reg = /^([[:alnum:]\.\'[0-9]]+ ?)*$/i
	zip_reg = /^\d{5}([\-]\d{4})?$/
	phone_reg = /^\d{3}\-\d{3}\-\d{4}$/

#######  Validations
	validates_format_of :name, with: name_reg
	validates_format_of :street_address, with: address_reg
	validates_format_of :zip_code, with: zip_reg
	validates_format_of :phone_number, with: phone_reg
  
#######  Query Methods
  
  def self.search( query )
    where do
      (name =~ "%#{query}%") | (city =~ "%#{query}%")  
    end  
  end
  
  def self.featured( zip_code )
    possible_listings = self.search( zip_code )
    possible_listings.where( featured: true )
  end
  
  
########  Proceedural Methods
	
  def safe_photo_url
    photo_url || "http://placekitten.com/150/150"  
  end
  
  def formated_phone_number
    "(#{phone_number[0..2]})-#{phone_number[3..6]}-#{phone_number[0..9]}"
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
    (name.size > 20) ? "#{name[0..19]}..." : name
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

end
