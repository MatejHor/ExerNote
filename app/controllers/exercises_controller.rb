class ExercisesController < ApplicationController
  include WardenHelper
  def show
    @exercise = Exercise.find(params[:id])
    # @exercise.exercise_nodes = ExerciseNode.where(exercise_id: @exercise.id)
    render
  end

  def index
    @exercises_day = []

    if signed_in?
      @exercises = Exercise.where(user_id: current_user['id']).order(created_at: :desc).paginate(page: params[:page])
      exercises = []
      (1..@exercises.length).each do |i|
        exercises.push(@exercises[i - 1])
        date = @exercises[i - 1].created_at.strftime('%d.%m.%Y')
        if (@exercises[i].equal? nil) || (!date.eql? @exercises[i].created_at.strftime('%d.%m.%Y'))
          @exercises_day.push(exercises)
          exercises = []
        end
      end
    else
      @exercises = Exercise.where(user_id: 0).order(created_at: :desc).paginate(page: params[:page])
    end

  end

  def new
  end

  def create
    Exercise.create(exercise_params)
    redirect_to root_path
  end

  def destroy
    Exercise.destroy(params[:id])
    redirect_to root_path
  end

  def update
    Exercise.update(id = params[:id], exercise_params)
    redirect_to exercise_path(params[:id])
  end

  private

  def exercise_params
    if params[:exercise][:distance].eql? ""
      params[:exercise][:distance] = nil
    end
    params.require(:exercise).permit(:title, :time, :created_at, :distance, :user_id)
  end

  def parse_json(json)
    ActiveSupport::JSON.decode json.to_s.gsub('=>', ':')
  end
end
