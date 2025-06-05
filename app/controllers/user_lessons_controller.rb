# app/controllers/user_lessons_controller.rb
# [...]
class UserLessonsController < ApplicationController
  # Add id to the list of actions below
  # before_action :set_user_lesson, only: %i[id]

  def show
    @user_lesson = UserLesson.find(params[:id])
  end

  private

  # def user_lesson_params
    # params.require(:user_lesson).permit(:name, :number, :concept, :description, :level)
  # end
end
