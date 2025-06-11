class Lesson < ApplicationRecord
  belongs_to :level
  has_many :users, through: :user_lessons
end
