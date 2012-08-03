class DispensaryCommentsController < ApplicationController
def user_index
    @user = current_user
    @comments = @user.dispensary_comments
    render layout: 'cadets'
  end
  
  def update
    comment = current_user.dispensary_comments.where( id: params[:id] ).first
    comment.body = params[:dispensary_comment][:body]
    comment.save
    redirect_to user_dispensary_comments_path, notice: 'Comment was successfully updated.'
  end

  def destroy
    current_user.dispensary_comments.find( params[:id] ).destroy
    redirect_to user_dispensary_comments_path, alert: 'Comment Destroyd'
  end
end
