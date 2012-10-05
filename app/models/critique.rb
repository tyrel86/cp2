class Critique < ActiveRecord::Base
  attr_accessible :title, :content, :photo, :critique_type

  belongs_to :user
	belongs_to :dispensary
 
	has_attached_file :photo, :styles => { :large => "300x300#", :small => "150x150#" }
 
	def critique_type=(input)
		type = ((input == "dispensary") ? true : false )
		write_attribute(:critique_type, type)
	end

  def exerpt( words_to_limit_to )
		content_array = content.split(' ')
		num_of_words = content_array.size
		if num_of_words < words_to_limit_to
			content
		else
			content_array[0...words_to_limit_to].join + "..."
		end
  end
  
  def critique_type
    type = read_attribute(:critique_type)
    type ? "dispensary" : "strain"
  end

  def self.search( query )
    where do
      (title =~ "%#{query}%") | (content =~ "%#{query}%")  
    end  
  end
end
