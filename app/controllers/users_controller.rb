class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    user_params = params[:user]
    value_hash = { user_name: user_params[:user_name], email: user_params[:email],
                          password: user_params[:password], 
                          password_confirmation: user_params[:password_confirmation] }
    @user = User.new( value_hash )
    if verify_recaptcha( model: @user, message: "The captcha did not match" ) and @user.save
      @user.roles << Role.where( name: "anonymous" ).first
      @user.roles << Role.where( name: "base" ).first
      @user.user_profile = UserProfile.new( birth_day: Date.new )
      session[:user_id] = @user.id
      redirect_to user_profile_path( current_user ), notice: "Thank you for signing up!"
    else
			render "new", layout: "empty"
    end
  end
end
