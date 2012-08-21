class Critique < ActiveRecord::Base
  attr_accessible :title, :content, :photo, :critique_type

  belongs_to :user
 
	has_attached_file :photo, :styles => { :large => "300x300#", :small => "150x150#" }
 
	def critique_type=(input)
		type = ((input == "dispensary") ? true : false )
		write_attribute(:critique_type, type)
	end
  
  def critique_type
    type = read_attribute(:critique_type)
    type ? "dispensary" : "strain"
  end
  
end
