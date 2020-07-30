class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises, force: :cascade do |t|
      t.string :title
      t.string :time
      t.datetime :created_at, precision: 6, null: false
      t.datetime :updated_at, precision: 6, null: false
      t.jsonb :exercises, default: [], null: false
      t.string :distance
    end
  end
end
