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
    @levels = current_user.user_levels.includes(:level)
    @completed_levels = @levels.select(&:completed)
    @current_level = @levels.find { |user_level| !user_level.completed }

    # see the last achievement
    @last_achievement = current_user.achievements.order(created_at: :desc).first

    # see the last 5 achievements
    @recent_achievements = current_user.achievements.order(created_at: :desc).limit(5)
  end
end
