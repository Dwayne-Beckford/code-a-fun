class AddFieldsToUserLessons < ActiveRecord::Migration[7.1]
  def change
    add_column :user_lessons, :user_input, :text
    add_column :user_lessons, :ai_response, :text
  end
end
