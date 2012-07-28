class DispensariesController < ApplicationController
  
  def create
    p = params[:dispensary]
    d = Dispensary.new( p )
    if d.save
      current_user.dispensaries << d
      redirect_to controller: :cadets, action: :dispensaries 
    else
      redirect_to controller: :cadets, action: :dispensaries
    end  
  end

  def update
    d = current_user.dispensaries.where( id: params[:id] ).first
    d.update_attributes( params[:dispensary] )
    redirect_to controller: :cadets, action: :dispensaries
  end
  
  def destroy
    d = current_user.dispensaries.where( id: params[:id] ).first
    d.destroy
    redirect_to controller: :cadets, action: :dispensaries
  end

end
