class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :dashboard]

  def home
  end

  def dashboard
    # all completed user lessons
    @completed_lessons = UserLesson.where("completed = ? AND user_id = ?", true, current_user.id)

    # see next lesson (safe even if user hasn't completed any)
    if @completed_lessons.any?
      next_number = @completed_lessons.last.lesson.number + 1
      @next_lesson = Lesson.find_by(number: next_number)
    else
      @next_lesson = Lesson.find_by(number: 1)
    end

    # see all completed user levels
    @levels = UserLevel.where("completed = ? AND user_id = ?", true, current_user.id)
  end

end
