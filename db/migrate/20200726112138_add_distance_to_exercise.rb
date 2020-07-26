class AddDistanceToExercise < ActiveRecord::Migration[6.0]
  def change
    add_column :exercises, 'distance', :string, null: true
  end
end
