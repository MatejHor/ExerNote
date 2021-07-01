class SearchExercisesController < ApplicationController
  include WardenHelper

  # This methods (query) need postgres extension: CREATE EXTENSION unaccent;
  # it will remove diacritics from text
  def index
    @exercises = []
    @title = params[:title]

    unless params[:title].nil? || params[:title].eql?("")
      exercise_name = "%" + (params[:title].downcase.gsub(/[[:punct:]]/, '')) + "%"
      # exercise_name = "%" + ("Benc".downcase.gsub(/[[:punct:]]/, '')) + "%"

      @exercise_nodes = ExerciseNode
                          .where("unaccent(lower(exercise_nodes.title)) like ?", exercise_name)
                          .where("exercises.user": current_user['id'])
                          .joins(:exercise)
                          .order("exercises.created_at DESC")
                          .paginate(page: params[:page])

      @exercise_nodes.each do |node|
        exercise = {}
        exercise["title"] = node.title
        exercise["weight"] = node.weight
        exercise["series"] = node.series
        exercise["exercise_title"] = node.exercise.title
        exercise["exercise_created_at"] = node.exercise.created_at
        exercise["exercise_id"] = node.exercise.id
        @exercises.append(exercise)
      end
    end

  end
end
