namespace :roles do

  desc "Clears roles and auth data"
  task clear: :environment do
		Role.destroy_all
		Right.destroy_all
		Assingment.destroy_all
	end
	
	task partial_clear: :environment do
		Role.destroy_all
		Right.destroy_all
	end

	task addto: :environment do
		
	end

	desc "Populates roles and auth data from lib/tasks/roles.rake"
	task populate: :environment do
	  #Define Roles
		anonymous = Role.create( name: "Anonymous" )
		base = Role.create( name: "Base" )
		author = Role.create( name: "Author" )
		editor = Role.create( name: "Editor" )
		moderator = Role.create( name: "Moderator" )
		admin = Role.create( name: "Admin" )
		
		#Define rights
		#Static pages
		home_page_view = Right.create( resource: "pages", operation: "HOME" )
		  anonymous.rights << home_page_view

		#Users
		user_create = Right.create( resource: "users", operation: "CREATE" )
		  anonymous.rights << user_create
		user_read = Right.create( resource: "users", operation: "READ" )
		  base.rights << user_read
		user_update = Right.create( resource: "users", operation: "UPDATE" )
		  base.rights << user_update
		user_delete = Right.create( resource: "users", operation: "DELETE" )
		  base.rights << user_delete

		#User profiles
		user_profile_create = Right.create( resource: "user_profiles", operation: "CREATE" )
		  base.rights << user_profile_create
		user_profile_read = Right.create( resource: "user_profiles", operation: "READ" )
		  base.rights << user_profile_read
		user_profile_update = Right.create( resource: "user_profiles", operation: "UPDATE" )
		  base.rights << user_profile_update
		user_profile_delete = Right.create( resource: "user_profiles", operation: "DELETE" )
		  base.rights << user_profile_delete
    user_profile_manage = Right.create( resource: "user_profiles", operation: "MANAGE" )
		  base.rights << user_profile_manage
		  
		#Articles
		article_create = Right.create( resource: "articles", operation: "CREATE" )
		  author.rights << article_create
		article_read = Right.create( resource: "articles", operation: "READ" )
		  anonymous.rights << article_read
		article_update = Right.create( resource: "articles", operation: "UPDATE" )
		  author.rights << article_update
		article_delete = Right.create( resource: "articles", operation: "DELETE" )
		  author.rights << article_delete
		article_manage = Right.create( resource: "articles", operation: "MANAGE" )
		  author.rights << article_manage

		#Roachy Lessons
		lesson_create = Right.create( resource: "lessons", operation: "CREATE" )
		  admin.rights << lesson_create
		lesson_update = Right.create( resource: "lessons", operation: "UPDATE" )
		  admin.rights << lesson_update
		lesson_delete = Right.create( resource: "lessons", operation: "DELETE" )
		  admin.rights << lesson_delete
		lesson_manage = Right.create( resource: "lessons", operation: "MANAGE" )
		  admin.rights << lesson_manage

		#Ads
		ad_create = Right.create( resource: "ads", operation: "CREATE" )
		  base.rights << ad_create
		ad_update = Right.create( resource: "ads", operation: "UPDATE" )
		  base.rights << ad_update
		ad_delete = Right.create( resource: "ads", operation: "DELETE" )
		  base.rights << ad_delete
		ad_manage = Right.create( resource: "ads", operation: "MANAGE" )
		  base.rights << ad_manage

		#Article Comments
		article_comment_create = Right.create( resource: "article_comments", operation: "CREATE" )
		  base.rights << article_comment_create
		article_comment_read = Right.create( resource: "article_comments", operation: "READ" )
		  anonymous.rights << article_comment_read
		article_comment_update = Right.create( resource: "article_comments", operation: "UPDATE" )
		  base.rights << article_comment_update
		article_comment_delete = Right.create( resource: "article_comments", operation: "DELETE" )
		  base.rights << article_comment_delete
		article_comment_manage = Right.create( resource: "article_comments", operation: "MANAGE" )
		  base.rights << article_comment_manage

		#Critiques
		critique_create = Right.create( resource: "critiques", operation: "CREATE" )
		  author.rights << critique_create
		critique_read = Right.create( resource: "critiques", operation: "READ" )
		  anonymous.rights << critique_read
		critique_update = Right.create( resource: "critiques", operation: "UPDATE" )
		  author.rights << critique_update
		critique_delete = Right.create( resource: "critiques", operation: "DELETE" )
		  author.rights << critique_delete
		critique_manage = Right.create( resource: "critiques", operation: "MANAGE" )
		  author.rights << critique_manage
		
		#Dispensaries
		dispensary_create = Right.create( resource: "dispensaries", operation: "CREATE" )
		  base.rights << dispensary_create
		dispensary_read = Right.create( resource: "dispensaries", operation: "READ" )
		  anonymous.rights << dispensary_read
		dispensary_update = Right.create( resource: "dispensaries", operation: "UPDATE" )
		  base.rights << dispensary_update
		dispensary_delete = Right.create( resource: "dispensaries", operation: "DELETE" )
		  base.rights << dispensary_delete
		dispensary_manage = Right.create( resource: "dispensaries", operation: "MANAGE" )
		  base.rights << dispensary_manage
		dispensary_admin = Right.create( resource: "dispensaries", operation: "ADMIN" )
		  admin.rights << dispensary_admin

		#Dispensary Comments
		dispensary_comment_create = Right.create( resource: "dispensary_comments", operation: "CREATE" )
		  base.rights << dispensary_comment_create
		dispensary_comment_read = Right.create( resource: "dispensary_comments", operation: "READ" )
		  anonymous.rights << dispensary_comment_read
		dispensary_comment_update = Right.create( resource: "dispensary_comments", operation: "UPDATE" )
		  base.rights << dispensary_comment_update
		dispensary_comment_delete = Right.create( resource: "dispensary_comments", operation: "DELETE" )
	    base.rights << dispensary_comment_delete
	 dispensary_comment_manage = Right.create( resource: "dispensary_comments", operation: "MANAGE" )
	    base.rights << dispensary_comment_manage

	  #User Dispensary Review
		user_dispensary_review_create = Right.create( resource: "user_dispensary_reviews", operation: "CREATE" )
      base.rights << user_dispensary_review_create
		user_dispensary_review_read = Right.create( resource: "user_dispensary_reviews", operation: "READ" )
		  anonymous.rights << user_dispensary_review_read
		user_dispensary_review_update = Right.create( resource: "user_dispensary_reviews", operation: "UPDATE" )
		  base.rights << user_dispensary_review_update
		user_dispensary_review_delete = Right.create( resource: "user_dispensary_reviews", operation: "DELETE" )
      base.rights << user_dispensary_review_delete
    user_dispensary_review_manage = Right.create( resource: "user_dispensary_reviews", operation: "MANAGE" )
      base.rights << user_dispensary_review_manage

	  #Volumes
		volume_create = Right.create( resource: "volumes", operation: "CREATE" )
      editor.rights << volume_create
		volume_read = Right.create( resource: "volumes", operation: "READ" )
		  anonymous.rights << volume_read
		volume_update = Right.create( resource: "volumes", operation: "UPDATE" )
		  editor.rights << volume_update
		volume_delete = Right.create( resource: "volumes", operation: "DELETE" ) 
      editor.rights << volume_delete
    volume_manage = Right.create( resource: "volumes", operation: "MANAGE" ) 
      editor.rights << volume_manage
      
    #Sessions
    session_delete = Right.create( resource: "volumes", operation: "DELETE" ) 
      base.rights << session_delete
    session_create = Right.create( resource: "sessions", operation: "CREATE" )
      anonymous.rights << session_create
      
	end

  desc "Makes all current users base and annonomous and sets up annoumous user"
	task initialize: :environment do
		User.all.each do |u|
		  u.roles << Role.where( name: "Anonymous" )
		  u.roles << Role.where( name: "Base" )
    end
    u = User.where( user_name: "anonymous" ).first
    u.destroy if u
    u = User.create( user_name: "anonymous", email: "dontbother@somewhere.com", 
                              password: "%TGBnhy6&UJ", password_confirmation: "%TGBnhy6&UJ" )
    u.roles << Role.where( name: "Anonymous" )

		#Admins and edditors
		u = User.first
		u.roles << Role.where( name: "Author" )
		u.roles << Role.where( name: "Editor" )
		u.roles << Role.where( name: "Moderator" )
		u.roles << Role.where( name: "Admin" )
	end
  
  desc "Clears and then recreates roles and auth data from lib/tasks/roles.rake"
	task update: :environment do
		Rake::Task["roles:clear"].execute
		Rake::Task["roles:populate"].execute
		Rake::Task["roles:initialize"].execute
	end

  desc "Clears and then recreates roles and auth data from lib/tasks/roles.rake"
	task update_keep_assignments: :environment do
		Rake::Task["roles:partial_clear"].execute
		Rake::Task["roles:populate"].execute
	end

  desc "If you only want to add a right or two do it here and rewrite in the global obove to avoid momentary lapse"
	task temp: :environment do
	  #Define Roles keep for all uses
		anonymous = Role.where( name: "Anonymous" )
		base = Role.where( name: "Base" ).first
		author = Role.where( name: "Author" )
		editor = Role.where( name: "Editor" )
		moderator = Role.where( name: "Moderator" )
		admin = Role.where( name: "Admin" )
		#Define temp tasks bellow
		ad_create = Right.create( resource: "ads", operation: "CREATE" )
		  base.rights << ad_create
		ad_update = Right.create( resource: "ads", operation: "UPDATE" )
		  base.rights << ad_update
		ad_delete = Right.create( resource: "ads", operation: "DELETE" )
		  base.rights << ad_delete
		ad_manage = Right.create( resource: "ads", operation: "MANAGE" )
		  base.rights << ad_manage
	end

  desc "Keep track of all users for production"
	task power_up: :environment do
	  #Define Roles keep for all uses
		anonymous = Role.where( name: "Anonymous" )
		base = Role.where( name: "Base" )
		author = Role.where( name: "Author" )
		editor = Role.where( name: "Editor" )
		moderator = Role.where( name: "Moderator" )
		admin = Role.where( name: "Admin" )
		#Define temp tasks bellow
		  u = User.where( user_name: "cpeditor" ).first #Micha
		    u.roles << author
		    u.roles << editor
		    u.roles << moderator
		  u = User.where( user_name: "cpeditor" ).first #Tyrel
		    u.roles << admin
	end

end
