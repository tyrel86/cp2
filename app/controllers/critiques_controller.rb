class CritiquesController < ApplicationController

  def user_index
    @user = current_user
    @critiques = @user.critiques
    render layout: 'cadets'
  end
  
  def index
    @critiques = Critique.all
    @critiques ||= []
		@critiques.reverse!
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
  end
  
  def index_dispensaries
    @critiques = Critique.where( critique_type: true )
    @critiques ||= []    
		@critiques.reverse!
  end

  def dispensary_index
    @critiques = Critique.where( critique_type: true )  
  end
  
  def strain_index
    @critiques = Critique.where( critique_type: false )  
  end
  
  def create
    c = Critique.create( params[:critique] )
    current_user.critiques << c
    redirect_to user_critiques_path( current_user )
  end

  def update
    critique = current_user.critiques.where( id: params[:id] ).first
    if critique.update_attributes( params[:critique] )
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
