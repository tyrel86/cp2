class Article < ActiveRecord::Base
  attr_accessible :content, :editorial, :title, :source, :clicks
  
  belongs_to :user
  belongs_to :volume
  has_many :article_comments

	validates_presence_of :content, :title, :source

  def exerpt( words_to_limit_to )
		content_array = content.split(' ')
		num_of_words = content_array.size
		if num_of_words < words_to_limit_to
			content
		else
			content_array[0...words_to_limit_to].join(' ') + "..."
		end
  end

		
  def self.search( query )
    where do
      (title =~ "%#{query}%") | (content =~ "%#{query}%")  
    end  
  end

	def self.array_of_article_urls
    self.all.inject([]) do |articles, article|
      articles.push( article.source )  
    end  
  end
	
end
