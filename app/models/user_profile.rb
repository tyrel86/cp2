class UserProfile < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :birth_day, :gender, :favorite_strains

  before_validation :populate_with_defaults
  def populate_with_defaults
    birth_day ||= Date.today - 21.years
  end

	#Regular expressions
	name_reg = /\A[a-z\']*\z/i

	#Validations
	#Names
	validates_format_of :first_name, with: name_reg
	validates_format_of :last_name, with: name_reg
	#Dates
	validates_class_of :birth_day, class: Date	

	#Data acsess and prosessing methods
	def full_name
	  "#{first_name} #{last_name}"
 end
	
	def age
		now = Time.now.utc.to_date
		now.year - birth_day.year - (birth_day.to_date.change(:year => now.year) > now ? 1 : 0)
	end

	def gender=(input)
	  gender = ((input == "male") ? true : false )
    write_attribute(:gender, gender)
  end
  
  def gender
    gender = read_attribute(:gender)
    gender ? "male" : "female"
  end

end
