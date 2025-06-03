class CreateUserLevels < ActiveRecord::Migration[7.1]
  def change
    create_table :user_levels do |t|
      t.boolean :completed, default: false
      t.references :user, null: false, foreign_key: true
      t.references :level, null: false, foreign_key: true

      t.timestamps
    end
  end
end
