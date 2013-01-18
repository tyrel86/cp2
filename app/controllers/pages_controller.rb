class PagesController < ApplicationController
	
	def home	
	end
	
	def birthday
		render layout: "plain"
	end

	def rsvp
		Rsvp.create( params["rsvp"] )
    redirect_to root_path, notice: 'Your rsvp has been submited enjoy the party and the rest of your day'
	end
  	
end
