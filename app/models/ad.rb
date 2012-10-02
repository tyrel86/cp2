class Ad < ActiveRecord::Base
  attr_accessible :ad_type_id, :href, :name, :image

	has_attached_file :image, :styles => { :side => "250x250>", :btob => "728x90>" }

	belongs_to :user

	def ad_type_id=(input)
    type = case input
			when "side"
				0
			when "btob"
				1
			else
				0
		end
    write_attribute( :ad_type_id, glass_sale )
  end
  
  def glass_sale
    input = read_attribute(:gender)
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
