class CreateExerciseNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :exercise_nodes do |t|
      t.string :title
      t.string :series
      t.string :weight
      t.integer :exercise_id

      t.timestamps
    end
  end
end
