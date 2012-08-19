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
    Search.create_or_inc( s, :listing ) 
    @dispensaries = Dispensary.search( s )
    @dispensaries.sort! { |a,b| a.average_rating <=> b.average_rating }
    @dispensaries.reverse!
    @featured = Dispensary.where( featured: true ).first
    @sub_featured = Dispensary.where( sub_featured: true )
    @first_sub_featured = @sub_featured.sample
    @sub_featured -= [@first_sub_featured]
  end
 
	def nearyou
		client_ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
		#For development environment
		client_ip = "71.208.115.67" if client_ip == '127.0.0.1'
		user_location = UserLocation.new_from_ip( client_ip )
		dispensary_array = Dispensary.all
		@dispensaries = dispensary_array.inject([]) do |r,d|
			r ||= []
			r.push(d) if Dispensary.distance_between( user_location, d ) <= 10
			r
		end
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
