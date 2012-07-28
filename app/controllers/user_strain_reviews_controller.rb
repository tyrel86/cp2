class UserStrainReviewsController < ApplicationController
  
  def update
    review = current_user.user_strain_reviews.find( params[:id] )
    strain = Strain.find( review.strain_id )
    strain.review( current_user.id, params[:user_strain_review][:couch_lock], 
                          params[:user_strain_review][:creativity] )
    redirect_to "/cadets/strain_reviews", notice: 'Review was successfully updated.'
  end
  
  def destroy
    current_user.user_strain_reviews.find( params[:id] ).destroy
    redirect_to "/cadets/news_posts", alert: 'Review Destroyd'
  end

  def create
    #NEEDS WORK
    review =  UserStrainReview.new( params[:user_strain_review] )
    current_user.articles << article
    if article.user_id == current_user.id
      redirect_to "/cadets/news_posts", alert: 'Review Created'
    else
      redirect_to "/cadets/news_posts", alert: 'Review Could not be created'
    end
  end
  
end
