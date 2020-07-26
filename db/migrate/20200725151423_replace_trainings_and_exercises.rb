class ReplaceTrainingsAndExercises < ActiveRecord::Migration[6.0]
  def change
    rename_table :trainings, :training_exer
    rename_table :exercises, :exercises_train
  end
end
