class HoursOfOperationsController < ApplicationController

  def update
		hoo = @current_user.dispensaries.where( id: params[:hours_of_operation][:dispensary_id] ).first.hours_of_operation
		params[:hours_of_operation].remove!(:dispensary_id)
		if hoo.update_attributes( params[:hours_of_operation] )
			redirect_to user_dispensaries_path( @current_user ), alert: "Business hours have been set"
		else
			redirect_to user_dispensaries_path( @current_user ), alert: "Business hours update failed"
		end	
  end

  def admin_update
		hoo = Dispensary.where( id: params[:hours_of_operation][:dispensary_id] ).first.hours_of_operation
		params[:hours_of_operation].remove!(:dispensary_id)
		if hoo.update_attributes( params[:hours_of_operation] )
			redirect_to user_dispensaries_admin_path( @current_user ), alert: "Business hours have been set"
		else
			redirect_to user_dispensaries_admin_path( @current_user ), alert: "Business hours update failed"
		end	
  end

end
