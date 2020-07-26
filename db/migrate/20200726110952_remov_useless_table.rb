class RemovUselessTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :trainings
    drop_table :exercise_nodes
  end
end
