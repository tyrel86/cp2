class Feed < ActiveRecord::Base
  attr_accessible :name, :uri

	#Obtains an instance of Feedzirra for a URL
  def get_rss_feed( atempts )
			feed = Feedzirra::Feed.fetch_and_parse( uri , { :max_redirects => atempts })
	end	

	def fetch_articles
    current_feed = get_rss_feed( 5 )
		if current_feed.class == Feedzirra::Parser::RSS
			self.status = true
		else
			self.status = false
		end
		self.save
		if status
			current_feed.entries.each do |article|
					unless Article.array_of_article_urls.include?(article.url)
						a = Article.new(title: article.title, content: article.content, source: article.url, clicks: 0)
						a.title ||= article.summary
						a.content ||= article.summary
						a.save
					end
			end
		end
	end

	def display_status
		if status
			"<span class='label label-success'>Success</span>"
		else
			"<span class='label label-important'>Fail</span>"
		end
	end

end
