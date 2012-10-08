class Step
	attr_accessor :name, :required_association, :action, :controller
end

module StepByStep
	
	def set_steps( array_of_steps )
		@steps = array_of_steps
	end
	
	def current_step
		
	end

end
