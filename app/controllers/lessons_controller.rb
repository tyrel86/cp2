class LessonsController < ApplicationController
  
  def user_index
    @lessons = Lesson.all
    render layout: 'cadets'
  end
  
  def update
    lesson = Lesson.find( params[:id] )
    if lesson.update_attributes( params[:lesson] )
      redirect_to user_lessons_path( current_user ), notice: 'Lesson was successfully updated.'
    else
      redirect_to user_lessons_path( current_user ), alert: 'Invalid paramiters for article'
    end
  end
  
  def destroy
    Lesson.find( params[:id] ).destroy
    redirect_to user_lessons_path( current_user ), alert: 'Lesson Destroyd'
  end

  def create
    lesson =  Lesson.new( params[:lesson] )
    if lesson.save
      redirect_to user_lessons_path( current_user ), alert: 'Lesson Created'
    else
      redirect_to user_articles_path( current_user ), alert: 'Lesson Could not be created'
    end
  end
end
