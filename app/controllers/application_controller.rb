class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_authorization

  private
    def current_user
      u = User.find(session[:user_id]) if session[:user_id]
      u ||= nil
      u || anonymous
    end
    helper_method :current_user
    
    def current_user?
      current_user.user_name != "anonymous"
    end
    helper_method :current_user?

    def loged_in?
      current_user.user_name != "anonymous"
    end
    helper_method :loged_in?

    def authorize
      redirect_to new_session_path, alert: "You need to be logged in to do that" if current_user.nil?
    end
    helper_method :authorize
    
    def anonymous
      User.where( user_name: "anonymous" ).first
    end
    helper_method :anonymous
    
    def check_authorization
      unless current_user.can?( action_name, controller_name )
        redirect_to root_path,
                           flash: { error: "What you trying to pull homes you cant do that!" }
      end
    end
    helper_method :check_authorization
      
end
