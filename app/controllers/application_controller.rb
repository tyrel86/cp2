class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_authorization, :update_user_loation

  private
		def update_user_loation
			if ((not session[:user_location].nil?) and (params[:search_from].nil?))
				return		
			end
			unless params[:search_from].nil?
				derive_location_from_input
				return
			end
			derive_location_from_ip
			return
		end

		def derive_location_from_ip
			client_ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
			#For development environment
				client_ip = "71.208.115.67" if client_ip == '127.0.0.1'
			session[:user_location] = UserLocation.new_from_ip( client_ip )
			params[:last_location] = session[:user_location].max_info_string
		end

		def derive_location_from_input
			session[:user_location] = UserLocation.new_from_location( params[:search_from] )
			params[:last_location] = session[:user_location].max_info_string
		end
    
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
