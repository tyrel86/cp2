namespace :admin do

	desc "Restarts the Web Server asumes you are root"
	task rsws: :environment do
		sys_ps_dump = `ps -e | grep ruby`
	  reg = /[0-9]/	
		parrent_ruby_ps_id = sys_ps_dump.match( reg )[0]
		if( system( "kill #{parrent_ruby_ps_id}" )
			puts "Shuting down ruby unicorn demon"
		else
			puts "RSWS rake task failed run with --trace for more info"
			return
		end
		system( "cd /home/CannaPages" )
		system( "unicorn_rails -c config/unicorn.rb -D -E production" )
	end

	desc "Resets the asset cache by removing old and recompiling"
	task :rac
		system( "cd /home/CannaPages" )
		system( "rm -r public/assets" )
		Rake::Task["assets:precompile"].execute
	end


	desc "Hard reset of web server"
	task :hrsws
		Rake::Task["admin:rac"].execute
		Rake::Task["admin:rsws"].execute
	end

end
