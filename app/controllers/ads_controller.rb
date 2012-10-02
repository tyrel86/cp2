class AdsController < ApplicationController

  def user_index
    @user = current_user
    @ads = @user.ads
    render layout: 'cadets'
  end
  
  def update
    ad = current_user.ads.where( id: params[:id] ).first
    if ad.update_attributes( params[:ad] )
      redirect_to user_articles_path( current_user ), notice: 'Ad was successfully updated.'
    else
      redirect_to user_articles_path( current_user ), alert: 'Invalid paramiters for ad'
    end
  end

  def destroy
    current_user.ads.find( params[:id] ).destroy
    redirect_to user_articles_path( current_user ), alert: 'Ad Destroyd'
  end

  def create
		debugger
    ad =  Ad.create( params[:ad] )
    current_user.ads << ad
    if ad.user_id == current_user.id
      redirect_to user_ads_path( current_user ), alert: 'Ad Created'
    else
      redirect_to user_ads_path( current_user ), alert: 'Ad Could not be created'
    end
  end
  
end
