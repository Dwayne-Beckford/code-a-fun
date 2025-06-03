class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.integer :number
      t.string :name
      t.references :level, null: false, foreign_key: true
      t.text :concept
      t.text :task
      t.text :description

      t.timestamps
    end
  end
end
