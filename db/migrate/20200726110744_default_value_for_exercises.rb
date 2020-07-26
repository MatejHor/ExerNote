class DefaultValueForExercises < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:exercises, :exercises, [])
  end
end
