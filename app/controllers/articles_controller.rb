class ArticlesController < ApplicationController

  def user_index
    @articles = current_user.articles
  end
  
  def show
    @article = Article.find( params[:id] )
  end
  
  def update
    article = current_user.articles.where( id: params[:id] ).first
    if article.update_attributes( params[:article] )
      redirect_to "/cadets/news_posts", notice: 'Article was successfully updated.'
    else
      redirect_to "/cadets/news_posts", alert: 'Invalid paramiters for article'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end
  
  def destroy
    current_user.articles.find( params[:id] ).destroy
    redirect_to "/cadets/news_posts", alert: 'Article Destroyd'
  end

  def create
    article =  Article.new( params[:article] )
    current_user.articles << article
    if article.user_id == current_user.id
      redirect_to "/cadets/news_posts", alert: 'Article Created'
    else
      redirect_to "/cadets/news_posts", alert: 'Article Could not be created'
    end
  end
  
end
