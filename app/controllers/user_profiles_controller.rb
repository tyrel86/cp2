class UserProfilesController < ApplicationController
  before_filter :authorize

  def show
    @user = current_user
    @user_profile = @user.user_profile
    render :layout => 'cadets'
  end

  def edit
    @user_profile = UserProfile.find( params[:id] )
  end

  def update
    @user_profile = UserProfile.find( params[:id] )
    if @user_profile.update_attributes( params[:user_profile] )
      redirect_to user_profile_path( current_user ), notice: 'User profile was successfully updated.'
    else
      redirect_to user_profile_path( current_user ), notice: 'Invalid'
    end
  end

end
