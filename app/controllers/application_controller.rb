class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_authorization

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def current_user?
      current_user.nil? ? false : true
    end

    def authorize
      redirect_to new_session_path, alert: "You need to be logged in to do that" if current_user.nil?
    end
    helper_method :current_user, :current_user?
    
    def any_one
      User.where( user_name: "anonymous" ).first
    end
    
    def check_authorization
      current_user
      case current_user?
        when true
          unless current_user.can?( action_name, controller_name )
            redirect_to root_path,
                               flash: { error: "What you trying to pull homes you cant do that!" }
          end
        else false
          unless any_one.can?( action_name, controller_name )
            redirect_to root_path,
                               flash: { error: "What you trying to pull homes you cant do that!" }
          end
      end
    end
    helper_method :check_authorization
      
end
