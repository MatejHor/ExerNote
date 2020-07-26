class CreateExerciseNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :exercise_nodes do |t|
      t.string :title
      t.string :weight
      t.string :series
      t.integer :exercise_id

      t.timestamps
    end
  end
end
