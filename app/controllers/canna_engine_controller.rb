class CannaEngineController < ApplicationController

  def dispensaries
    s = params[:search_term]
    Search.create_or_inc( s ) 
    @dispensaries = Dispensary.search( s )
    @dispensaries.sort! { |a,b| a.average_rating <=> b.average_rating }
    @dispensaries.reverse!
    @featured = Dispensary.where( featured: true ).first
    @sub_featured = Dispensary.where( sub_featured: true )
    @first_sub_featured = @sub_featured.sample
    @sub_featured -= [@first_sub_featured]
  end

end
