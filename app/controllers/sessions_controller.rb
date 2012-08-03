class SessionsController < ApplicationController
  def new
    @active = :cadets
  end

  def create
    user = User.find_by_user_name(params[:user_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_profile_path( current_user ), notice: "Logged in!"
    else
      flash.now.alert = "Username or password is invalid."
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
