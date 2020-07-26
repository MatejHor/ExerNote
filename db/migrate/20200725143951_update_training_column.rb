class UpdateTrainingColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :trainings, :datetime
    add_column :trainings, :training_date, :datetime
    change_column :trainings, :exercises, :text
  end

  def down
    remove_column :trainings, :training_date
    add_column :trainings, :datetime, :string
    change_column :trainings, :exercises, :string
  end
end
