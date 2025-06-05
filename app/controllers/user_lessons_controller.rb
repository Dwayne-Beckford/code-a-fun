# app/controllers/user_lessons_controller.rb
# [...]
class UserLessonsController < ApplicationController
  # Add id to the list of actions below
  # before_action :set_user_lesson, only: %i[id]

  def show
    @user_lesson = UserLesson.find(params[:id]) 
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: "Provide feedback to a students coding input in Ruby. Use fun encouraging tone of voice and be very specific about where the error is. Do not give an answer but you can ask questions that will help the student figure it out. The feedback shouldn’t be too long. Bear in mind you don’t know what student attempt is this so avoid phrases like “great start”.
Here’s the lesson name:#{@user_lesson.lesson.name}
Here’s the lesson description:#{@user_lesson.lesson.description}
Here’s the lesson concept the person has been taught:#{@user_lesson.lesson.concept}
Here’s the lesson task:#{@user_lesson.lesson.task}
Here’s the student answer: puts 'Hey Sam! Let’s grab some popcorn and code together!'"}]
    })
    @content = chatgpt_response["choices"][0]["message"]["content"]
  end

  private

  # def user_lesson_params
    # params.require(:user_lesson).permit(:name, :number, :concept, :description, :level)
  # end
end
