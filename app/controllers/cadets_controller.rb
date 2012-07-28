class CadetsController < ApplicationController
  before_filter :authorize
 
  def user_profile
    @user = current_user
    @user_profile = @user.user_profile
  end
  
  def news_posts
    @user = current_user
    @articles = @user.articles
  end
  
  def news_comments
    @user = current_user
    @article_comments = @user.article_comments
  end

  def strain_reviews
    @user = current_user
    @strain_reviews = @user.user_strain_reviews
  end
  
  def strain_wikis
    @user = current_user
    @strain_wikis = @user.user_strain_wikis
  end
  
  def master_strain_wikis
    @strain_wikis = UserStrainWiki.all.sort_by(&:updated_at).reverse
  end
  
  def volumes
    @volumes = Volume.all(:order => 'created_at DESC')
  end

  def critiques
    @user = current_user
    @critiques = @user.critiques
  end
  
  def dispensaries
    @dispensaries = current_user.dispensaries
  end
  
end
