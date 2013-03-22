class Volume < ActiveRecord::Base
  attr_accessible :current, :photo
  
	embed
	has_attached_file :photo, :styles => { :large => "400x300#", :small => "200x150#" }

  def self.the_current
    where( current: true ).first
  end
  
  def set_as_current
    the_current = Volume.the_current
    the_current.update_attributes( current: false ) if the_current
    self.current = true
    self.save
  end
  
  def as_three_columns_array
    col1 = []
    col2 = []
    col3 = []
    rotator = Rotator.new( 1, 1, 3 )
    self.articles.each do |a|
      eval "col#{rotator.val}.push a"
      rotator.incriment
    end
		if col2.size >= col3.size
			col2.push col2.last
			col2.pop
		end
    [col1,col2,col3]
  end

end
