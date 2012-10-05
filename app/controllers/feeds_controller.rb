class FeedsController < ApplicationController

	def index
		@feeds = Feed.all
	end

	def pull
		prvSize = Article.all.size
		Feed.all.each do |feed|
			feed.fetch_articles
		end
		newSize = Article.all.size
		dif = newSize - prvSize
		redirect_to admin_feeds_path, alert: "#{dif} New articles have been added"
	end

  def user_index
    @feeds = Feed.all
    render layout: 'cadets' 
  end

  def create
		feed = Feed.new( params[:feed] )
    if feed.save
      redirect_to admin_feeds_path, alert: 'RSS Feed Created'
    else
      redirect_to admin_feeds_path, alert: 'RSS Feed Could not be created'
    end
 
  end

  def update
		feed = Feed.find( params[:id] )
    if feed.update_attributes( params[:feed] )
      redirect_to admin_feeds_path, notice: 'RSS Feed was successfully updated.'
    else
      redirect_to admin_feeds_path, alert: 'Invalid paramiters for RSS Feed'
    end
  end

  def destroy
    Feed.find( params[:id] ).destroy
    redirect_to admin_feeds_path, alert: 'RSS Feed Destroyd'
  end

end
