class ExerciseNode < ApplicationRecord
  belongs_to :exercise
  # Number of records in page
  self.per_page = 10
end
