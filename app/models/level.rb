class Level < ApplicationRecord
    has_many :lessons

    def completed_by_user?(user)
        lessons.all? { |lesson| user.user_lessons.completed.pluck(:lesson_id).include?(lesson.id) }
    end
end
