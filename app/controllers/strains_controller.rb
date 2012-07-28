class StrainsController < ApplicationController

	def index
		@strains = Strain.all
	end

end
