class ArticleComment < ActiveRecord::Base
  attr_accessible :body
  
  belongs_to :user
end
