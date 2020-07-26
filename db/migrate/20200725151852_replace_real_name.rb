class ReplaceRealName < ActiveRecord::Migration[6.0]
  def change
    rename_table :training_exer, :exercises
    rename_table :exercises_train, :trainings
  end
end
