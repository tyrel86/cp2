class Critique < ActiveRecord::Base
  attr_protected

  belongs_to :user
  
  	def critique_type=(input)
	    type = ((input == "dispensary") ? true : false )
      write_attribute(:critique_type, type)
    end
  
  def critique_type
    type = read_attribute(:critique_type)
    type ? "dispensary" : "strain"
  end
  
end
