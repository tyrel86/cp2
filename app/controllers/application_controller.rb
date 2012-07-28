class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def current_user?
      current_user.nil? ? false : true
    end

    def authorize
      redirect_to new_session_path, alert: "Not authorized" if current_user.nil?
    end
    helper_method :current_user, :current_user?
      
end
