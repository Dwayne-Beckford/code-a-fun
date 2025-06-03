class Level < ApplicationRecord
    has_many :lessons
    has_many :user_levels
    has_many :users, through: :user_levels
end
