class UserDispensaryReviewsController < ApplicationController
  
  def create
    dispensary = Dispensary.find( params[:user_dispensary_review][:dispensary_id] )
    user = current_user
    dispensary.review( user.id, params[:user_dispensary_review][:bud_tenders], 
                                  params[:user_dispensary_review][:selection], 
                                  params[:user_dispensary_review][:atmosphere] )
    redirect_to dispensary
  end
  
  def update
    dispensary = Dispensary.find( params[:user_dispensary_review][:dispensary_id] )
    user = current_user
    dispensary.review( user.id, params[:user_dispensary_review][:bud_tenders], 
                                  params[:user_dispensary_review][:selection], 
                                  params[:user_dispensary_review][:atmosphere] )
    redirect_to user_user_dispensary_reviews_path, notice: 'review was successfully updated.'
  end

  def destroy
    current_user.user_dispensary_reviews.find( params[:id] ).destroy
    redirect_to user_user_dispensary_reviews_path, alert: 'Review Destroyd'
  end

  def user_index
    @user = current_user
    @dispensary_reviews = @user.user_dispensary_reviews
    @dispensary_reviews ||= []
    render layout: 'cadets'
  end

end

