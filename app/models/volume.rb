class Volume < ActiveRecord::Base
  attr_accessible :current, :photo_url
  
  has_many :articles

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
    [col1,col2,col3]
  end

end
