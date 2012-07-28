class User < ActiveRecord::Base
	#Built in ruby model method to add functionality for user authentication
	has_secure_password
  
	#White list for mass asignable
	attr_accessible :user_name, :password, :password_confirmation, :email

	# Relational Asociations
	has_one :user_profile
	has_many :dispensary_comments
	has_many :user_strain_wikis #AKA user strain wiki proposals
	has_many :user_strain_reviews
	has_many :articles
	has_many :article_comments
	has_many :critiques
	has_many :dispensaries
	
	#REGEX deffinitions
	user_name_reg = /\A[a-zA-Z0-9\-\_\.]*\z/i
	password_reg = /\A[\S]*\z/i
	email_reg = /^([\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+\.)*[\w\!\#$\%\&\'\*\+\-\/\=\?\^\`{\|\}\~]+@((((([a-z0-9]{1}[a-z0-9\-]{0,62}[a-z0-9]{1})|[a-z])\.)+[a-z]{2,6})|(\d{1,3}\.){3}\d{1,3}(\:\d{1,5})?)$/i
	# old_email_reg = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/	

	#Validations
	#Global
		validates :user_name, :password, :password_confirmation, :email, presence: true
	#User name
		validates_uniqueness_of :user_name
		validates_format_of :user_name, with: user_name_reg
		validates :user_name, :length => { :in => 5..15 }
	#Email
		validates_uniqueness_of :email
		validates_format_of :email, with: email_reg
	#Password
		validates :password, :length => { :in => 8..20 }
		validates_format_of :password, with: password_reg

	def write_dispensary_comment( dispensary, body )
		d = DispensaryComment.create 	body: body
		d['user_id'] = self.id
		d['dispensary_id'] = dispensary.id
		d.save
	end

  def write_article_comment( article, body )
		d = ArticleComment.create 	body: body
		d['user_id'] = self.id
		d['article_id'] = article.id
		d.save
	end

	def create_wiki_proposal( strain_id, flavors, effect, health_benefits, sativa_indica, ideal_growing_conditions, origin ) 
		previous_wiki_proposal = self.user_strain_wikis.where( strain_id: strain_id ).first
		params = { 	flavors: flavors, effect: effect, health_benefits: health_benefits, sativa_indica: sativa_indica,
								ideal_growing_conditions: ideal_growing_conditions, origin: origin }
		if previous_wiki_proposal.nil?		
			usw = UserStrainWiki.create( params )
			usw.user_id = self.id
			usw.strain_id = strain_id
			usw.save
		else
			previous_wiki_proposal.update_attributes( params )
		end
	end

	def get_wiki( strain_id )
		self.user_strain_wikis( strain_id: strain_id ).first
	end

end
