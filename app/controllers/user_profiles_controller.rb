class UserProfilesController < ApplicationController
  before_filter :authorize

  def show
    @user = current_user
    @user_profile = @user.user_profile
		@lessons = Lesson.all
    render :layout => 'cadets'
  end

	def edit
		@user_profile = @current_user.user_profile
		flash[:notice] = "You must complete your contact data before we can acsept ads or listings from you sory for the inconvience" unless has_contact_info?
		render :layout => 'cadets'
	end

  def update
    @user_profile = @current_user.user_profile
    if @user_profile.update_attributes( params[:user_profile] )
      redirect_to user_profile_path( current_user ), notice: 'User profile was successfully updated.'
    else
      redirect_to user_profile_path( current_user ), notice: 'Invalid'
    end
  end

end
