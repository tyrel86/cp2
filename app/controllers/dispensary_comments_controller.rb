class DispensaryCommentsController < ApplicationController
  
  def create
    @user = current_user
    @comment = DispensaryComment.new( body: params[:dispensary_comment][:body] )
    @comment.dispensary_id = params[:dispensary_comment][:dispensary_id]
    @comment.user_id = @user.id
    @comment.save
    redirect_to Dispensary.find( params[:dispensary_comment][:dispensary_id] )
  end
  
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
