class AddFieldIntoUser < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :email, :nick
    add_column :users, :email, :string
    add_column :users, :name, :string
    add_column :users, :password, :string
  end
end
