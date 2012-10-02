class DispensariesController < ApplicationController
  before_filter :authorize, only: [:user_index, :create, :update, :destroy]

  def show
    @dispensary = Dispensary.find(params[:id])
  end

  def user_index
    @dispensaries = current_user.dispensaries
    render layout: 'cadets'
  end

	def admin_index
		@dispensaries = Dispensary.search( params[:search_term], :all )
		@dispensaries = Kaminari::PaginatableArray.new( @dispensaries ).page(params[:page]).per(30)
		render layout: 'cadets'
	end

	def search
		params[:radius] ||= 5
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
    @featured = @dispensaries.select{|d| d.featured == true }
		render "search"
	end

	def nearyou
		params[:radius] ||= 5
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
		@dispensaries = Kaminari::PaginatableArray.new( @dispensaries ).page(params[:page]).per(10)
		if params[:category] != :all
			@dispensaries.select do |d|
				d.business_type == params[:category]
			end
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
    redirect_to user_dispensaries_path( current_user )
  end

end
