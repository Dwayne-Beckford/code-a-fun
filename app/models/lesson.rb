class Lesson < ApplicationRecord
  belongs_to :level
  has_many :user_levels
  has_many :users, through: :user_lessons
end
