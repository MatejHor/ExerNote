class ExercisesController < ApplicationController
  def show
    @exercise = Exercise.find(params[:id])
    @exercise.exercises = parse_json @exercise.exercises
    render
  end

  def index
    @exercises_day = []
    db_exercise = Exercise.order(created_at: :desc).all
    exercises = []
    (1..db_exercise.length).each do |i|
      exercises.push(db_exercise[i - 1])
      date = db_exercise[i - 1].created_at.strftime('%d.%m.%Y')
      if (db_exercise[i].equal? nil) || (!date.eql? db_exercise[i].created_at.strftime('%d.%m.%Y'))
        @exercises_day.push(exercises)
        exercises = []
      end
    end
  end

  def new
  end

  def create
    if params[:exercise][:distance] == ""
      params[:exercise][:distance] = nil
    end
    Exercise.create(params[:exercise])
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
    params.require(:exercise).permit(:title, :time, :created_at, :distance)
  end

  def parse_json(json)
    ActiveSupport::JSON.decode json.to_s.gsub('=>', ':')
  end
end
