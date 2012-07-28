class UserStrainWikisController < ApplicationController
 
  def update
    wiki = current_user.user_strain_wikis.find( params[:id] )
    wiki.update_attributes( params[:user_strain_wiki] )
    redirect_to "/cadets/strain_wikis", notice: 'Review was successfully updated.'
  end
  
  def destroy
    current_user.user_strain_wikis.find( params[:id] ).destroy
    redirect_to "/cadets/strain_wikis", alert: 'Wiki Proposal Destroyd'
  end

  def create
    #NEEDS WORK
    review =  UserStrainReview.new( params[:user_strain_review] )
    current_user.articles << article
    if article.user_id == current_user.id
      redirect_to "/cadets/strain_wikis", alert: 'Review Created'
    else
      redirect_to "/cadets/strain_wikis", alert: 'Review Could not be created'
    end
  end

end
