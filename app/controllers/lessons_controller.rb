class LessonsController < ApplicationController
    def show
        @lessons = Lesson.find(params[:id])
    end
end
