class ArticlesController < ApplicationController

  def index
    @articles = Article.all
    @articles ||= []
  end

	def search
    s = params[:search_term]
		f = params[:search_from]
    Search.create_or_inc( s, f, :listing ) 
		@articles = Article.search( s )
		unless @articles.empty?
			render "index"
		else
			render "shared/empty_query"
		end
	end
  
  def user_index
    @user = current_user
    @articles = @user.articles
    render layout: 'cadets'
  end
  
  def show
    @article = Article.find( params[:id] )
		@article.clicks += 1
		@article.save
    @article_comments = @article.article_comments
    @current_user = current_user
  end
  
  def update
    article = current_user.articles.where( id: params[:id] ).first
    if article.update_attributes( params[:article] )
      redirect_to user_articles_path( current_user ), notice: 'Article was successfully updated.'
    else
      redirect_to user_articles_path( current_user ), alert: 'Invalid paramiters for article'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end
  
  def destroy
    current_user.articles.find( params[:id] ).destroy
    redirect_to user_articles_path( current_user ), alert: 'Article Destroyd'
  end

  def create
    article = Article.new( params[:article] )
		article.source = "http://www.cannapages.com"
		article.clicks = 0
    current_user.articles << article
    if article.user_id == current_user.id
      redirect_to user_articles_path( current_user ), alert: 'Article Created'
    else
      redirect_to user_articles_path( current_user ), alert: 'Article Could not be created'
    end
  end
  
end
