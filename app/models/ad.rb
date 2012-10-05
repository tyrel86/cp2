class Ad < ActiveRecord::Base
  attr_accessible :ad_type_id, :href, :name, :image

	has_attached_file :image, :styles => { :side => "250x250>", :btob => "728x90>" }

	belongs_to :user

	def expiration_date
		if( expiration.nil? )
			"<span class='label label-warning'>Inactive</span>"
		elsif( expiration < Date.today )
			"<span class='label label-info'>Expired</span>"
		else
			"<span class='label label-info'>#{ expiration }</span>"
		end
	end

	def url
		((href =~ /http\:\/\//) == 0) ? href : "http://#{href}"
	end

	def status
		self.confirmed ? "<span class='label label-success'>Live</span>" : "<span class='label label-info'>Pending payment and aproval</span>"
	end

	def self.get_ads( amount, type )
		type = ({ side: 0, btob: 1})[type]
		ads = Ad.where( confirmed: true, ad_type_id: type ).order( 'ads.shows ASC' ).limit( amount )
		ads.each do |ad|
			ad.shows += 1
			ad.save
		end
		ads
	end

	def ad_type_id=(input)
    type = case input
			when "side"
				0
			when "btob"
				1
			else
				0
		end
    write_attribute( :ad_type_id, type )
  end
  
  def ad_type_id
    input = read_attribute(:ad_type_id)
    case input
			when 0
				"side"
			when 1
				"btob"
			else
				"btob"
		end
  end	

	belongs_to :ad_type
end
