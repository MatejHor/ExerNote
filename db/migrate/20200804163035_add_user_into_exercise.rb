class AddUserIntoExercise < ActiveRecord::Migration[6.0]
  def change
    add_reference :exercises, :user, index: true, foreign_key: true, null: true
  end
end
