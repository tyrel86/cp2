module ApplicationHelper
  def active?(sym)
    @active == sym ? "class=active" : ""  
  end
  
  def login_or_backend
    if current_user?
      link_to "CannCadets", cadets_user_profile_path
    else
      link_to "CannCadets", "#editmodal-login", "data-toggle" => "modal"
    end
    
  end
  
end
