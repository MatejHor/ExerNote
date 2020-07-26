class ExercisesController < ApplicationController
  def show
    @exercise = Exercise.find(params[:id])
    @exercise.exercises = ActiveSupport::JSON.decode @exercise.exercises.to_s.gsub('=>', ':')
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
    render
  end

  def new
    @exercise_id = Exercise.maximum(:id).next
    render
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
    redirect_to root_path
  end

  private

  def exercise_params
    params.require(:exercise).permit(:title, :time, :created_at)
  end
end
