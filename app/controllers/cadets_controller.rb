class CadetsController < ApplicationController
  before_filter :authorize

  def critiques
    @user = current_user
    @critiques = @user.critiques
  end
  
  def dispensaries
    @dispensaries = current_user.dispensaries
  end
  
end
