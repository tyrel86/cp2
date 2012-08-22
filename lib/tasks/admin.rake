namespace :admin do

	desc "Restarts the Web Server asumes you are root"
	task rsws: :environment do
		sys_ps_dump = `ps -e | grep ruby`
	  reg = /(\d+)/
		parrent_ruby_ps_id = sys_ps_dump.match( reg )[0]
		puts "Found master ruby ps as #{parrent_ruby_ps_id}"
		system( "kill #{parrent_ruby_ps_id}" )
		system( "cd /home/CannaPages" )
		system( "unicorn_rails -c config/unicorn.rb -D -E production" )
	end

	desc "Resets the asset cache by removing old and recompiling"
	task rac: :environment do
		system( "cd /home/CannaPages" )
		system( "rm -r public/assets" )
		Rake::Task["assets:precompile"].execute
	end

	desc "Hard reset of web server"
	task hrsws: :environment do
		Rake::Task["admin:rac"].execute
		Rake::Task["admin:rsws"].execute
	end

	
	desc "Full update from github with hard reset"
	task update_site: :environment do
		system( "cd /home/CannaPages" )
		system( "get pull" )
		Rake::Task["admin:hrsws"].execute
	end

end
