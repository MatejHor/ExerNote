class UpdateTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :exercises, 'series'
    remove_column :exercises, 'weigh'
    add_column :exercises, 'time', :string, null: true
    add_column :exercises, :exercises, :jsonb, null: false, default: []
    add_column :exercises, 'distance', :string, null: true
  end
end
