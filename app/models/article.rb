class Article < ActiveRecord::Base
  attr_accessible :content, :editorial, :title
  
  belongs_to :user
  belongs_to :volume
  has_many :article_comments

  def exerpt
    "#{(content.size > 250) ? content[0..250] : content}..."
  end

		
  def self.search( query )
    where do
      (title =~ "%#{query}%") | (content =~ "%#{query}%")  
    end  
  end
end
