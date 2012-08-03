class ArticleCommentsController < ApplicationController
  
  def user_index
    @user = current_user
    @article_comments = @user.article_comments
    render layout: 'cadets'
  end
  
  def update
    comment = current_user.article_comments.where( id: params[:id] ).first
    comment.body = params[:article_comment][:body]
    comment.save
    comment.reload
    if comment.body == params[:article_comment][:body]
      redirect_to user_article_comments_path( current_user ), notice: 'Comment was successfully updated.'
    else
      redirect_to user_article_comments_path( current_user ), alert: 'Invalid paramiters for comment'
    end
  end

  def destroy
    current_user.article_comments.find( params[:id] ).destroy
    redirect_to user_article_comments_path( current_user ), alert: 'Comment Destroyd'
  end
  
end
