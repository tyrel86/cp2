class CritiquesController < ApplicationController

	def show
		@critique = Critique.find( params[:id] )
	end

  def user_index
    @user = current_user
    @critiques = @user.critiques
    render layout: 'cadets'
  end
  
  def index
    @critiques = Critique.all
    @critiques ||= []
		@critiques.reverse!
		#Ads
		@ads = Ad.get_ads( 4, :side )
  end

	def index_for_listing
		@dispensary = Dispensary.find( params[:id] )
		@critiques = @dispensary.critiques
		render "index"
	end
  
	def search
    s = params[:search_term]
		f = params[:search_from]
    Search.create_or_inc( s, f, :critique ) 
		@critiques = Critique.search( s )
		render "index"
	end

  def index_strains
    @critiques = Critique.where( critique_type: false )
    @critiques ||= []
		@critiques.reverse!
		render 'index'
  end
  
  def index_dispensaries
    @critiques = Critique.where( critique_type: true )
    @critiques ||= []    
		@critiques.reverse!
		render 'index'
  end

  def dispensary_index
    @critiques = Critique.where( critique_type: true )  
		render 'index'
  end
  
  def strain_index
    @critiques = Critique.where( critique_type: false )  
		render 'index'
  end
  
  def create
		dispensary_id = params[:critique][:dispensary_id]
		params[:critique].remove!(:dispensary_id)	
    c = Critique.create( params[:critique] )
		c.dispensary_id = dispensary_id
    current_user.critiques << c
    redirect_to user_critiques_path( current_user )
  end

  def update
		dispensary_id = params[:critique][:dispensary_id]
		params[:critique].remove!(:dispensary_id)	
    critique = current_user.critiques.where( id: params[:id] ).first
    if critique.update_attributes( params[:critique] )
			critique.dispensary_id = dispensary_id
			critique.save
      redirect_to user_critiques_path( current_user ), notice: 'Article was successfully updated.'
    else
      redirect_to user_critiques_path( current_user ), alert: 'Invalid paramiters for article'
    end
  end

  def destroy
    current_user.critiques.find( params[:id] ).destroy
    redirect_to user_critiques_path( current_user ), alert: 'Article Destroyd'
  end
  
end
