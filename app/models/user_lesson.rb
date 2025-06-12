class UserLesson < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  scope :completed, -> { where(completed: true ) }
  scope :incompleted, -> { where(completed: false )}

  def last_lesson_on_level?
    lesson.level.lessons.order(:number).last == lesson
  end
end
