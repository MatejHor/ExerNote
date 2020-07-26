class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :title
      t.string :weigh
      t.string :series

      t.timestamps
    end
  end
end
