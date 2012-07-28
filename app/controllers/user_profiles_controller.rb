class UserProfilesController < ApplicationController

  def edit
    @user_profile = UserProfile.find( params[:id] )
  end

  def update
    @user_profile = UserProfile.find( params[:id] )

    if @user_profile.update_attributes( params[:user_profile] )
      redirect_to "/cadets/user_profile", notice: 'User profile was successfully updated.'
    else
      redirect_to "/cadets/user_profile", notice: 'Invalid'
    end

  end

end
