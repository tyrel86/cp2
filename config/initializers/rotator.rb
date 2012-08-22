class Rotator
  attr_accessor :val, :min, :max
  
  def initialize( val, min, max )
    @val, @min, @max = val, min, max
  end
  
  def incriment
    (@val == @max) ? (@val = @min) : (@val += 1)
  end
end
