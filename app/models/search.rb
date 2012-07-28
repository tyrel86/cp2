class Search < ActiveRecord::Base
  attr_protected

  def self.create_or_inc( check_search_term )
    previous = Search.find_by_search_term( check_search_term )
    unless previous
      Search.create( search_term: check_search_term, num_of_searches: 1 )
    else
      previous.num_of_searches += 1
      previous.save
    end
  end
  
  def type=(input)
	  type = case input
      when :listing
	      0
      when :critique
        1
      when :dispatch
        2
      when :strain
        3
      when :coupon
        4
	  end
	  write_attribute(:type, type)
  end
  
  def type
    type = read_attribute(:gender)
    case type
      when 1
        :listing
      when 2
        :dispatch
      when 3
        :strain
      when 4
        :coupon
      else
        :unknown
    end
  end

end
