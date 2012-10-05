
class DailySpecialListsController < ApplicationController
  def update
		ds = @current_user.dispensaries.where( id: params[:daily_special_list][:dispensary_id] ).first.daily_special_list
		params[:daily_special_list].remove!(:dispensary_id)
		if ds.update_attributes( params[:daily_special_list] )
			redirect_to user_dispensaries_path( @current_user ), alert: "Specials have been set"
		else
			redirect_to user_dispensaries_path( @current_user ), alert: "Specials update failed"
		end	
  end
end
