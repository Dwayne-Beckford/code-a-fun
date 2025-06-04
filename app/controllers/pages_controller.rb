class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :dashboard]

  def home
  end

  def dashboard
    # all completed user lessons
    @completed_lessons = UserLesson.where("completed = ? AND user_id = ?", true, current_user)
    number = (@completed_lessons.last.lesson.number) + 1
    
    # see next lesson
    @next_lesson = Lesson.find_by(number:number )
    
    # see all completed user levels
    @levels = UserLevel.where("completed = ? And user_id = ?", true, current_user)
  end
end
