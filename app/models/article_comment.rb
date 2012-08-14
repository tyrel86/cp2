class ArticleComment < ActiveRecord::Base
  attr_accessible :body
  
  belongs_to :user

  belongs_to :article
end
