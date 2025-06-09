class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :dashboard]

  def home
  end

  def dashboard
    # all completed user lessons
    @completed_lessons = current_user.user_lessons.completed

    # see next lesson (safe even if user hasn't completed any)
    if @completed_lessons.any?
      next_number = @completed_lessons.last.lesson.number + 1
      @next_lesson = Lesson.find_by(number: next_number)
      if @next_lesson
        @user_lesson = UserLesson.find_or_create_by!(user: current_user, lesson: @next_lesson)
      else
        @user_lesson = nil
      end
    else
      @next_lesson = Lesson.find_by(number: 1)

      @user_lesson = UserLesson.find_or_create_by!(user: current_user, lesson: @next_lesson)
    end


    # see all completed user levels
    @levels = current_user.user_levels.completed
  end

end
