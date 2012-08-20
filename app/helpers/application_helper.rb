module ApplicationHelper
  def active?(sym)
    @active == sym ? "class=active" : ""  
  end
  
  def login_or_backend
    if current_user?
      out = link_to "Loged in as #{current_user.user_name}", user_profile_path( current_user )
    else
      out = link_to "Login", "#editmodal-login", "data-toggle" => "modal"
			out += "|"
    	out += link_to "Join", "#create_user_modal", "data-toggle" => :modal, class: "left-marg"
		end    
  end
  
  def current_volume_path
    v = Volume.the_current
    (v ? volume_path( v ) : "#")
  end
  
end
