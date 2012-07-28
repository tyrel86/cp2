class PagesController < ApplicationController
	
	def home	
	end

  def critiques
    case params[:type]
     when "dispensary"
        @critiques = Critique.where( critique_type: true )
      when "strain"
        @critiques = Critique.where( critique_type: false )
      else
        @critiques = Critique.all
    end
      
    @critiques ||= []
  end

  def news
    @volume = Volume.the_current
    @volume ||= Volume.all.sample
    (redirect_to root_path, alert: "No News at this time... so sorry" and return) unless @volume
    @col_array = @volume.as_three_columns_array
  end
  
  def articles
    @articles = Article.all
    @articles ||= []
  end
  	
  def wiki
    @strains = Strain.all
  end
  	
end
