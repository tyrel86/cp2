class ArticleCommentsController < ApplicationController
  def update
    comment = current_user.article_comments.where( id: params[:id] ).first
    comment.body = params[:article_comment][:body]
    comment.save
    comment.reload
    if comment.body == params[:article_comment][:body]
      redirect_to "/cadets/news_comments", notice: 'Comment was successfully updated.'
    else
      redirect_to "/cadets/news_comments", alert: 'Invalid paramiters for comment'
    end
  end

  def create
    #NEEDS WORK
    article = Article.find( params[:id] )
    current_user.write_article_comment( article, params[:article_comment][:body] ) 
    if article.user_id == current_user.id
      redirect_to "/cadets/news_posts", alert: 'Article Created'
    else
      redirect_to "/cadets/news_posts", alert: 'Article Could not be created'
    end
  end

  def destroy
    current_user.article_comments.find( params[:id] ).destroy
    redirect_to "/cadets/news_comments", alert: 'Comment Destroyd'
  end
  
end
