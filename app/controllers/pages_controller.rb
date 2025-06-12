class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :dashboard]

  def home
  end

  def dashboard
    # all completed user lessons
    @completed_lessons = current_user.user_lessons.completed

    # figure out next lesson
    if @completed_lessons.any?
      next_number = @completed_lessons.last.lesson.number + 1
      @next_lesson = Lesson.find_by(number: next_number)
    else
      @next_lesson = Lesson.find_by(number: 1)
    end

    if @next_lesson
      # Create User Lesson entry if it doesn't exist
      @user_lesson = UserLesson.find_or_create_by!(user: current_user, lesson: @next_lesson)
    end

    # see all completed user levels
    @levels = current_user.completed_levels

    @current_level = current_user.user_lessons.where(completed: false).last.lesson.level
    @completed_in_current_level = @current_level.completed_by_user_count(current_user)
    @all_level_lessons = @current_level.lessons
    @uncompleted_in_current_level_count = @all_level_lessons.count - @completed_in_current_level

    # see the last achievement
    @last_achievement = current_user.achievements.order(created_at: :desc).first

    # see the last 5 achievements
    @recent_achievements = current_user.achievements.order(created_at: :desc).limit(5)

    @progress = current_user.level_progress(@current_level)
  end
end
