class Search < ActiveRecord::Base
  attr_accessible :search_term, :search_from, :num_of_searches, :search_type

  def self.create_or_inc( search_term, search_from, search_type )
    previous = Search.where( search_term: search_term, search_from: search_from ).first
    unless previous
      Search.create( search_term: search_term, search_from: search_from, num_of_searches: 1, search_type: search_type )
    else
      previous.num_of_searches += 1
      previous.save
    end
  end
  
  def search_type=(input)
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
	  write_attribute(:search_type, type)
  end
  
  def search_type
    type = read_attribute(:search_type)
    case type
      when 0
	      :listing
      when 1
        :critique
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
