class Exercise < ApplicationRecord
  # Number of records in page
  self.per_page = 15
  belongs_to :user
  has_many :exercise_nodes
end
