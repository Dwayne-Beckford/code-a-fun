# app/controllers/user_lessons_controller.rb
# [...]
class UserLessonsController < ApplicationController
  # Add id to the list of actions below
  # before_action :set_user_lesson, only: %i[id]

  def show
    @user_lesson = UserLesson.find(params[:id])
  end

  def feedback
    @user_lesson = UserLesson.find(params[:id])
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: "Provide feedback to a students coding input in Ruby. Use fun encouraging tone of voice and be very specific about where the error is. Do not give an answer but you can ask questions that will help the student figure it out. The feedback shouldn’t be too long. Bear in mind you don’t know what student attempt is this so avoid phrases like “great start”.
        Here’s the lesson name:#{@user_lesson.lesson.name}
        Here’s the lesson description:#{@user_lesson.lesson.description}
        Here’s the lesson concept the person has been taught:#{@user_lesson.lesson.concept}
        Here’s the lesson task:#{@user_lesson.lesson.task}
        Here’s the student answer:#{@user_lesson.user_input}"}]
    })

     @content = chatgpt_response["choices"][0]["message"]["content"]
    puts @content
    respond_to do |format|
      format.json {
        render json: @content.to_json
      }
    end
  end

  def update
    @user_lesson = UserLesson.find(params[:id])

    # Assign attributes with params
    @user_lesson.assign_attributes(user_lesson_params)

    # Validate user input with ai response
    @user_lesson.ai_response = validate_answer_with_ai(@user_lesson)

    # Set default to false
    @correct = false
    new_points = 0

    # Check for the word "correct" in ai response
    if @user_lesson.ai_response.downcase.include?("correct")
    @user_lesson.completed = true
    @correct = true
    end

    # Save the response and display response
    if @user_lesson.save
      respond_to do |format|
        format.turbo_stream do
            render turbo_stream: turbo_stream.replace(:ai_response, partial: "user_lessons/ai_response",
            locals: { content: @user_lesson.ai_response })
          end
        end
    else
      render :show, status: :processable_entity
    end

    #if last_lesson(lesson.numer == 6), => increment points and direct user to congrats page
    if @correct
      new_points += 10
      current_user.points += new_points
      current_user.save
    # elsif @user_lesson.lesson.number == 6
    #   new_points += 50
    end
  end

    # User input
  def userInput
    @questions = current_user.UserLesson
  end

  def completed
     @completed_lessons = current_user.user_lessons.completed
  end

  private
  # AI check user input and returns response
  def validate_answer_with_ai(user_lesson)
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: "Check a student's coding input in Ruby. If the answer is 90+% correct, just say 'Correct'. Otherwise, say 'You're not quite there. Press Test to get more hints'. Don't say anything else or rephrase. Stick to one of these exact sentences.
Here’s the lesson name:#{@user_lesson.lesson.name}
Here’s the lesson description:#{@user_lesson.lesson.description}
Here’s the lesson concept the person has been taught:#{@user_lesson.lesson.concept}
Here’s the lesson task:#{@user_lesson.lesson.task}
Here’s the student answer:#{user_lesson.user_input}"}]
    })
    chatgpt_response["choices"][0]["message"]["content"]
  end

  def user_lesson_params
    params.require(:user_lesson).permit(:user_input)
  end
end
