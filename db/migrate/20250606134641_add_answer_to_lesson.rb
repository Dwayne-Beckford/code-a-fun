class AddAnswerToLesson < ActiveRecord::Migration[7.1]
  def change
    add_column :lessons, :answer, :text
  end
end
