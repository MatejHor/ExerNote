class StatisticsController < ApplicationController
  include WardenHelper

  def index
    # User name
    @user_name = User.where("id": current_user['id'])[0].nick
    # Last exercise
    @last_exercise = Exercise
                       .where("exercises.user": current_user['id'])
                       .order("exercises.created_at DESC")
                       .limit(1)[0].created_at.to_date

    # Line chart of how long exercises takes in time
    @time_data = evolution_time
    # Top 5 done exercise node
    @top_exercise = top_exercise
    # Bottom 5 done exercise node
    @bottom_exercise = bottom_exercise
    # Evolution of weight for top 1 done exercise node
    @weight_evolution = evolution_ws
  end

  def evolution_time
    # Line chart of how long exercises takes in time
    # exercise_time_data = Exercise
    #                        .where("exercises.user": current_user['id'])
    #                        .where("exercises.title LIKE '%Cvicenie%'")
    #                        .where("exercises.time != ''")
    #                        .select("time")
    #                        .limit(100)
    exercise_nodes = ExerciseNode
                       .select("SUM(LEFT(series, position('x' in series) - 1)::decimal * RIGHT(series,length(series) - position('x' in series))::decimal) as sum, exercise_id")
                       .where("exercise_nodes.series LIKE '_x__' or exercise_nodes.series LIKE '_x_'")
                       .group(:exercise_id)
                       .to_sql
    exercise_time_data = Exercise
                           .joins("JOIN (#{exercise_nodes}) as nodes ON exercises.id = nodes.exercise_id")
                           .where("exercises.user": current_user['id'])
                           .where("exercises.title LIKE '%Cvicenie%'")
                           .where("exercises.time != ''")
                           .select("exercises.time, nodes.sum, (nodes.sum/exercises.time::decimal) as result")
                           .limit(100)
    Hash[(0...exercise_time_data.size).zip exercise_time_data.map(&:result)]
  end

  def top_exercise

    data = ExerciseNode
             .joins(:exercise)
             .where("exercises.user": current_user['id'])
             .group("BTRIM(unaccent(lower(exercise_nodes.title)))")
             .select("COUNT(*) as count, BTRIM(unaccent(lower(exercise_nodes.title))) as title")
             .order("count DESC")
             .limit(5)
    top_exercise = []
    data.each do |item|
      exercise = ExerciseNode
                   .joins(:exercise)
                   .where("exercises.user": current_user['id'])
                   .where("BTRIM(unaccent(lower(exercise_nodes.title))) like BTRIM(unaccent(?))", item.title)
                   .order("exercise_nodes.created_at DESC")
                   .select("exercise_nodes.title, exercise_nodes.weight, exercise_nodes.series")
                   .limit(1)
      top_exercise.append({ 'title' => exercise[0].title, 'weight' => exercise[0].weight, 'series' => exercise[0].series })
    end
    top_exercise
  end

  def bottom_exercise

    data = ExerciseNode
             .joins(:exercise)
             .where("exercises.user": current_user['id'])
             .where("exercise_nodes.title NOT LIKE '%+%'")
             # .where("position('<' in exercise_nodes.title)  0")
             .group("BTRIM(unaccent(lower(exercise_nodes.title)))")
             .select("COUNT(*) as count, BTRIM(unaccent(lower(exercise_nodes.title))) as title")
             .order("count ASC")
             .limit(5)
    bottom_exercise = []
    data.each do |item|
      exercise = ExerciseNode
                   .joins(:exercise)
                   .where("exercises.user": current_user['id'])
                   .where("BTRIM(unaccent(lower(exercise_nodes.title))) like BTRIM(unaccent(?))", item.title)
                   .order("exercise_nodes.created_at DESC")
                   .select("exercise_nodes.title, exercise_nodes.weight, exercise_nodes.series")
                   .limit(1)
      puts exercise[0].title
      bottom_exercise.append({ 'title' => exercise[0].title, 'weight' => exercise[0].weight, 'series' => exercise[0].series })
    end
    bottom_exercise
  end

  def evolution_ws

    data = ExerciseNode
             .joins(:exercise)
             .where("exercises.user": current_user['id'])
             .where("exercise_nodes.weight != ''")
             .group("BTRIM(unaccent(lower(exercise_nodes.title)))")
             .select("COUNT(*) as count, BTRIM(unaccent(lower(exercise_nodes.title))) as title")
             .order("count DESC")
             .limit(5)
    weight_evolution = []
    data.each do |item|
      exercise = ExerciseNode
                   .joins(:exercise)
                   .where("exercises.user": current_user['id'])
                   .where("exercise_nodes.weight != ''")
                   .where("exercise_nodes.series LIKE '_x__' OR exercise_nodes.series LIKE '_x_'")
                   .where("BTRIM(unaccent(lower(exercise_nodes.title))) like BTRIM(unaccent(?))", item.title)
                   .order("exercise_nodes.created_at DESC")
                   .select("exercise_nodes.title, exercise_nodes.weight, (LEFT(series, position('x' in series) - 1)::decimal * RIGHT(series, length(series) - position('x' in series))::decimal) as series")
                   .limit(100)

      weight_evolution.append({ 'title' => exercise[0].title,
                                'weights' => Hash[(0...exercise.size).zip exercise.map(&:weight)],
                                'series' => Hash[(0...exercise.size).zip exercise.map(&:series)] })
    end
    weight_evolution
  end
end
