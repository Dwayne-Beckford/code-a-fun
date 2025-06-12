class UserLesson < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  scope :completed, -> { where(completed: true ) }
  scope :incompleted, -> { where(completed: false )}
end
