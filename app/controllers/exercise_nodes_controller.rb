class ExerciseNodesController < ApplicationController
  def new
    render
  end

  def create
    Exercise.create(exercise_node_params)
  end

  def destroy
    ExerciseNode.destroy(params[:id])
  end

  def update
    render
  end

  private

  def exercise_node_params
    params.require(:exercise).permit(:title, :weight, :series, :exercise_id)
  end
end
