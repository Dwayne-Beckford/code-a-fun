class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :achievements
  has_many :user_lessons
  has_many :lessons, through: :user_lessons
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def create_user_lessons_for_lesson(lesson)
    Lesson.all.each do |lesson|
      self.user_lessons.find_or_create_by!(lesson: lesson)
    end
  end

  def current_level
    return Level.first if self.user_lessons.empty?

    if self.user_lessons.incompleted.first
      self.user_lessons.incompleted.first.lesson.level
    elsif self.user_lessons.completed.last
      self.user_lessons.completed.last.lesson.level
    end
  end


  def level_progress(level)
    total_lessons_count = level.lessons.count
    lesson_ids = level.lessons.pluck(:id)

    completed_lessons_count = self.user_lessons.completed.where(lesson: lesson_ids).count

    completed_lessons_count.to_f / total_lessons_count.to_f * 100
  end

  def completed_levels
    levels_array = Level.all.select do |level|
      level.completed_by_user?(self)
    end

    Level.where(id: levels_array.pluck(:id))
  end
end

