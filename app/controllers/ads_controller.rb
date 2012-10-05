class AdsController < ApplicationController

	def show
		@ad = Ad.find( params[:id] )
		@ad.clicks += 1
		@ad.save
		redirect_to @ad.url
	end

  def user_index
		if has_contact_info?
			@create_link = "#create_ad_modal"
		else
			@create_link = edit_user_profile_path( @current_user_profile )
		end
    @user = current_user
    @ads = @user.ads
    render layout: 'cadets'
  end

	def admin_index
		@ads = Ad.all
		render layout: 'cadets'
	end
  
  def update
    ad = current_user.ads.where( id: params[:id] ).first
    if ad.update_attributes( params[:ad] )
      redirect_to user_ads_path( current_user ), notice: 'Ad was successfully updated.'
    else
      redirect_to user_ads_path( current_user ), alert: 'Invalid paramiters for ad'
    end
  end

  def admin_update
    ad = Ad.where( id: params[:id] ).first
    if ad.update_attributes( params[:ad] )
      redirect_to admin_ads_path, notice: 'Ad was successfully updated.'
    else
      redirect_to admin_articles_path, alert: 'Invalid paramiters for ad'
    end
  end

  def destroy
    current_user.ads.find( params[:id] ).destroy
    redirect_to user_ads_path( current_user ), alert: 'Ad Destroyd'
  end

	def admin_destroy
		Ad.find( params[:id] ).destroy
		redirect_to admin_ads_path, alert: 'Ad Destroyd'
	end

  def create
		require_contact_info || return
    ad =  Ad.create( params[:ad] )
		ad.confirmed = false
		ad.shows = 0
		ad.clicks = 0
    current_user.ads << ad
    if ad.user_id == current_user.id
      redirect_to user_ads_path( current_user ), alert: 'Ad Created'
    else
      redirect_to user_ads_path( current_user ), alert: 'Ad Could not be created'
    end
  end

	def confirm
		ad = Ad.find( params[:id] )
		ad.confirmed = true
		ad.expiration = Date.today + 1.months
		ad.save
		redirect_to admin_ads_path, alert: 'Ad is ready to go'
	end

	def renew
		ad = Ad.find( params[:id] )
		ad.expiration = ad.expiration + 1.months
		ad.save
		redirect_to admin_ads_path, alert: 'Ad has been renewed'
	end
  
end
