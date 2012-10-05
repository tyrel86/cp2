namespace :rss do
 
  desc "Checks all feeds in database and adds new stories if present and removes 3 day old stories if pressent"
  task update: :environment do
	  Feed.all.each do |feed|
			feed.fetch_articles
		end
  end

end
