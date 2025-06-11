# app/controllers/user_lessons_controller.rb
# [...]
class UserLessonsController < ApplicationController
  # Add id to the list of actions below
  # before_action :set_user_lesson, only: %i[id]

  def show
    @user_lesson = UserLesson.find(params[:id])
    # UserLevel.find_or_create_by(user: current_user, level: @user_lesson.lesson.level)

    @next_lesson_number = @user_lesson.lesson.number + 1
    @next_level_number = @user_lesson.lesson.level.number + 1

    @next_lesson = Lesson.find_by(number: @next_lesson_number)

    if @next_lesson.present?
      @next_user_lesson = UserLesson.find_or_create_by(user: current_user, lesson: @next_lesson)
    else
      # level complete, go to next level
      @next_level = Level.find_by(number: @next_level_number)
      @next_lesson = Lesson.find_by(number: 1, level: @next_level)
      if @next_lesson
        @next_user_lesson = UserLesson.find_or_create_by(user: current_user, lesson: @next_lesson)
      end
      # else there is no more next_user_lesson
    end
  end

  def feedback
    @user_lesson = UserLesson.find(params[:id])
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: "Provide feedback to a students coding input in Ruby. Use fun encouraging tone of voice and be very specific about where the error is. Do not give an answer but you can ask questions that will help the student figure it out. The feedback shouldn’t be too long. Bear in mind you don’t know what student attempt is this so avoid phrases like “great start”.  If the answer is 90% or more correct, say that the answer is ready for submitting.
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

    if @user_lesson.save
      # Adding points for completing a lesson
      new_points += 10 if @correct
      current_user.points += new_points

      # Level logic
      # Get current level from the lesson
      current_level = @user_lesson.lesson.level

      # Get all lessons in this level
      lessons_in_level = Lesson.where(level: current_level).pluck(:id)
      level_lesson = lessons_in_level.count

      # Get completed lesson IDs for this user
      completed_lesson_ids = current_user.user_lessons.completed.pluck(:lesson_id)
      lesson_completed = completed_lesson_ids.count

      # Check if all lessons are completed
      all_completed = lessons_in_level.all? do |lesson_id|
        completed_lesson_ids.include?(lesson_id)
      end

      
      # If yes, mark level as completed
      if all_completed
        current_user.points += 40
        # 🎖️ Achievement based on level number
        badge = case current_level.number
        when 1 then "🥉"
        when 2 then "🥈"
        when 3 then "🥇"
        when 4 then "🎖️"
        when 5 then "🏆"
        else "🏅"
        end
        
        Achievement.find_or_create_by!(user: current_user, name: badge)
      end
      
      # adding progress to the progress bar
      @progress_add = lesson_completed.to_f / level_lesson.to_f
      
      current_user.save

      respond_to do |format|
        format.turbo_stream
            # do render turbo_stream: turbo_stream.replace(:ai_response, partial: "user_lessons/ai_response",
            # locals: { content: @user_lesson.ai_response })
          # end
        end
    else
      render :show, status: :unprocessable_entity
    end
  end


    #if last_lesson(lesson.numer == 6), => increment points and direct user to congrats page
    # if @correct
    #   new_points += 10
    #   current_user.points += new_points
    #   current_user.save
    # # elsif @user_lesson.lesson.number == 6
    # #   new_points += 50
    # end

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
      messages: [{ role: "user", content: "Check a student's coding input in Ruby. If the answer is 90% or more correct, just say 'Correct'. Otherwise, say 'You're not quite there. Press Test to get more hints'. Don't say anything else or rephrase. Stick to one of these exact sentences.
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
