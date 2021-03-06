class VolumesController < ApplicationController

  def current
		@volume = Volume.the_current
		if @volume
      @col_array = @volume.as_three_columns_array
      render "show"
		else
			redirect_to root_path
		end
  end

  def manage
    @volumes = Volume.all(:order => 'created_at DESC')
    render layout: 'cadets'
  end

  def index
    @volumes = Volume.all(:order => 'created_at DESC')
  end
  
  def show
    @volume = Volume.find( params[:id] )
    @col_array = @volume.as_three_columns_array
  end
  
  def create
    Volume.create( current: false )
    redirect_to manage_volumes_path
  end
  
  def set_as_current
    Volume.find( params[:id] ).set_as_current
    redirect_to manage_volumes_path
  end

  def update
    volume = Volume.find( params[:id] )
    volume.articles = []
    params[:volume][:article_ids].each do |article_id|
      volume.articles << Article.find( article_id ) unless article_id.empty?
    end
    volume.photo = params[:volume][:photo] unless params[:volume][:photo].nil?
    volume.save
    redirect_to manage_volumes_path
  end

  def destroy
    Volume.find( params[:id] ).destroy
    redirect_to manage_volumes_path
  end
  
end
