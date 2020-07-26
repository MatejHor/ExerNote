class ExerciseNodesController < ApplicationController
  def add_node
    exercise = Exercise.find(params[:id])

    node = {
        "title" => params[:title],
        "weight" => params[:weight],
        "series" => params[:series]
    }

    exercise.exercises.push(node)
    exercise.save

    redirect_to exercise_path(params[:id])
  end

  # TODO add remove exercise node
end
