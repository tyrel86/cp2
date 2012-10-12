class DispensariesController < ApplicationController
  before_filter :authorize, only: [:user_index, :create, :update, :destroy]

  def show
    @dispensary = Dispensary.find(params[:id])
		@dispensary.clicks += 1
		@dispensary.save
		@ads = Ad.get_ads( 2, :side )
  end

	def featured_show
		@dispensary = Dispensary.where(featured: true).find(params[:id])
		@dispensary.featured_clicks += 1
		@dispensary.save
		@ads = Ad.get_ads( 2, :side )
		render "show"
	end

  def user_index
    @dispensaries = current_user.dispensaries
    render layout: 'cadets'
  end

	def admin_index
		@dispensaries = Dispensary.search( params[:search_term], :all )
		@dispensaries = Kaminari::PaginatableArray.new( @dispensaries ).page(params[:page]).per(10)
		render layout: 'cadets'
	end

	def search
		params[:radius] ||= 10
		params[:radius] = (params[:radius]).to_i
		s = params[:search_term] || ""
		f = params[:search_from]
		Search.create_or_inc( s, f, :listing )
		dispensary_array = Dispensary.search( s, params[:category] )
		@dispensaries = dispensary_array.inject([]) do |r,d|
			r ||= []
			dist = Dispensary.distance_between( session[:user_location], d ) 
			if dist.class != String and dist <= params[:radius]
				r.push( d )
				d.distance = dist
			end
			r
		end
		if params[:category] != :all
			@dispensaries = @dispensaries.select do |d|
				d.business_type == params[:category]
			end
		end
		@dispensaries = Kaminari::PaginatableArray.new( @dispensaries ).page(params[:page]).per(10)
		@dispensaries.sort! { |a, b|  a.distance <=> b.distance }
    @featured = Dispensary.get_featured( session[:user_location].city, params[:category], 1 )
		@featured.each do |f|
			f.featured_shows += 1
			f.save
		end
		#Ads
		@ads = Ad.get_ads( 4, :side )

		render "search"
	end

  def create
    p = params[:dispensary]
    d = Dispensary.new( p )
    d.featured = false
		d.featured_shows = 0
		d.shows = 0
		d.featured_clicks = 0
		d.clicks = 0
		d.daily_special_list = DailySpecialList.new
		d.hours_of_operation = HoursOfOperation.new
    d.save
    current_user.dispensaries << d
    redirect_to user_dispensaries_path( @current_user )
  end

  def update
		if current_user.roles.where( name: "admin" ).size > 0
    	d = Dispensary.where( id: params[:id] ).first
		else
    	d = current_user.dispensaries.where( id: params[:id] ).first
		end
    d.update_attributes( params[:dispensary] )
    redirect_to user_dispensaries_path( current_user )
  end
  
  def destroy
		if current_user.roles.where( name: "admin" ).size > 0
    	d = Dispensary.where( id: params[:id] ).first
		else
    	d = current_user.dispensaries.where( id: params[:id] ).first
		end
    d.destroy
    redirect_to user_dispensaries_path( @current_user )
  end

	def request_featured
		dispensary = @current_user.dispensaries.find( params[:id] )
		dispensary.request_featured = true
		dispensary.save
		redirect_to user_dispensaries_path( @current_user ), alert: "You will recieve a call withen the business day that this request was issued or the next business day if it was issued after hours. Thank you for your interest we strive to get you the business you need."
	end

	def set_as_featured
		dispensary = Dispensary.find( params[:id] )
		dispensary.featured = true
		dispensary.request_featured = false
		dispensary.expiration = Date.today + 1.months
		dispensary.save
		redirect_to manage_featured_dispensaries_path( @current_user ), alert: "Listing is now featured"
	end

	def manage_featured
		@pending_dispensaries = Dispensary.where( request_featured: true )
		@dispensaries = Dispensary.where( featured: true ).order( 'dispensaries.expiration ASC' )
		render layout: 'cadets'
	end

	def renew_featured
		@dispensary = Dispensary.find( params[:id] )
		@dispensary.expiration = @dispensary.expiration + 1.months
		@dispensary.save
		redirect_to manage_featured_dispensaries_path, alert: "Listing has been renewed"
	end

end
