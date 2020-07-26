class RemoveTrainingsAddJson < ActiveRecord::Migration[6.0]
  def change
    remove_column :exercises, :exercises
    add_column :exercises, :exercises, :jsonb, null: false, default: '{}'
  end
end
