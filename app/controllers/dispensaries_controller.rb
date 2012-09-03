class DispensariesController < ApplicationController
  before_filter :authorize, only: [:user_index, :create, :update, :destroy]

  def show
    @dispensary = Dispensary.find(params[:id])
  end

  def user_index
    @dispensaries = current_user.dispensaries
    render layout: 'cadets'
  end

  def search
    s = params[:search_term]
		f = params[:search_from]
    Search.create_or_inc( s, f, :listing ) 
    @dispensaries = Dispensary.search( s ).page( params[:page] ).per( 10 )
		unless params[:category] == :all
			@dispensaries.select! { |d| d.business_type == params[:category] }
		end 
    @dispensaries.sort! { |a,b| a.average_rating <=> b.average_rating }
    @dispensaries.reverse!
		@dispensaries.each do |d|
			dist = Dispensary.distance_between( session[:user_location], d )
			d.distance = dist
		end
    @featured = @dispensaries.select{|d| d.featured == true }
  end
 
	def nearyou
		dispensary_array = Dispensary.all
		@dispensaries = dispensary_array.inject([]) do |r,d|
			r ||= []
			dist = Dispensary.distance_between( session[:user_location], d ) 
			if dist <= 5
				r.push( d )
				d.distance = dist
			end
			r
		end
    @featured = @dispensaries.select{|d| d.featured == true }
		render "search"
	end
 
  def create
    p = params[:dispensary]
    d = Dispensary.new( p )
    d.featured = false
    d.save
    current_user.dispensaries << d
    redirect_to user_dispensaries_path( current_user )
  end

  def update
    d = current_user.dispensaries.where( id: params[:id] ).first
    d.update_attributes( params[:dispensary] )
    redirect_to user_dispensaries_path( current_user )
  end
  
  def destroy
    d = current_user.dispensaries.where( id: params[:id] ).first
    d.destroy
    redirect_to user_dispensaries_path( current_user )
  end

end
