# app/controllers/feedbacks_controller.rb
# [...]
class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new #Needed to instantiate the form_with
  end
end
