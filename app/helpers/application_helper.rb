module ApplicationHelper
  def active?(sym)
    @active == sym ? "class=active" : ""  
  end
  
  def login_or_backend
    if current_user?
      link_to "CannaCadets", user_profile_path( current_user )
    else
      link_to "CannaCadets", "#editmodal-login", "data-toggle" => "modal"
    end    
  end
  
  def current_volume_path
    v = Volume.the_current
    (v ? volume_path( v ) : "#")
  end
  
end
