class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :achievements
  has_many :user_lessons
  has_many :user_levels 
  has_many :lessons, through: :user_lessons
  has_many :levels, through: :user_levels
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
