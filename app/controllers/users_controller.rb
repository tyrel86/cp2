class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    user_params = params[:user]
    value_hash = { user_name: user_params[:user_name], email: user_params[:email],
                          password: user_params[:password], 
                          password_confirmation: user_params[:password_confirmation] }
    @user = User.new(value_hash)
    if @user.save
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end
end
