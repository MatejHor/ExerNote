class UpdateTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :exercises, :series
    remove_column :exercises, :weight
    add_column :exercises, 'time', :string, null: true
    add_column :exercises, 'exercises', :json, default: [], null: true
    add_column :exercises, 'distance', :string, null: true
  end
end
