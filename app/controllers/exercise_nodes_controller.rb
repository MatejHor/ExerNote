class ExerciseNodesController < ApplicationController
  def add_node
    ExerciseNode.create(title: params[:title], weight: params[:weight], series: params[:series], exercise_id: params[:id])
    redirect_to exercise_path(params[:id])
  end

  def delete_node
    ExerciseNode.destroy(params[:exercise_node_id])
    redirect_to exercise_path(params[:id])
  end
end
