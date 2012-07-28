class CritiquesController < ApplicationController
  def create
    c = Critique.create( params[:critique] )
    current_user.critiques << c
    redirect_to cadets_critiques_path
  end

  def update
    critique = current_user.critiques.where( id: params[:id] ).first
    if critique.update_attributes( params[:critique] )
      redirect_to "/cadets/critiques", notice: 'Article was successfully updated.'
    else
      redirect_to "/cadets/critiques", alert: 'Invalid paramiters for article'
    end
  end

  def destroy
    current_user.critiques.find( params[:id] ).destroy
    redirect_to "/cadets/critiques", alert: 'Article Destroyd'
  end
  
end
