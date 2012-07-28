class VolumesController < ApplicationController
  
  def archive
    @volumes = Volume.all
  end
  
  def show
    @volume = Volume.find( params[:id] )
    @col_array = @volume.as_three_columns_array
  end
  
  def create
    Volume.create( current: false )
    redirect_to cadets_volumes_path
  end
  
  def set_as_current
    Volume.find( params[:id] ).set_as_current
    redirect_to cadets_volumes_path
  end

  def update
    volume = Volume.find( params[:id] )
    volume.articles = []
    params[:volume][:article_ids].each do |article_id|
      volume.articles << Article.find( article_id ) unless article_id.empty?
    end
    volume.photo_url = params[:volume][:photo_url]
    volume.save
    redirect_to cadets_volumes_path
  end

  def destroy
    Volume.find( params[:id] ).destroy
    redirect_to cadets_volumes_path
  end
end
