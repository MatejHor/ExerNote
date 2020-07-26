class RemoveExerciseDate < ActiveRecord::Migration[6.0]
  def change
    remove_column :exercises, :training_date
  end
end
