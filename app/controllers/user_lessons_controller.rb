# app/controllers/user_lessons_controller.rb
# [...]
class UserLessonsController < ApplicationController
  # Add id to the list of actions below
  # before_action :set_user_lesson, only: %i[id]

  def show
    @user_lesson = UserLesson.find(params[:id]) 
  end

  def update
    @user_lesson = UserLesson.find(params[:id])
    # assign attributes with params
    @user_lesson.assign_attributes(user_lesson_params)

    # validate user input with ai response
    @user_lesson.ai_response = validate_answer_with_ai(@user_lesson)
    # save the response and display response
    if @user_lesson.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:ai_response, partial: "user_lessons/ai_response",
          locals: { ai_response: @user_lesson.ai_response })
        end
      end
    else
      render :show, status: :processable_entity
    end
  end
    # User input
  def userInput
    @questions = current_user.UserLesson
  end

  private
  # AI check user input and returns response
  def validate_answer_with_ai(user_lesson)
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: user_lesson.user_input} ]
    })
    chatgpt_response["choices"][0]["message"]["content"]
  end

  def user_lesson_params
    params.require(:user_lesson).permit(:user_input)
  end
end
