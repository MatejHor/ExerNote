class StatisticsController < ApplicationController
  include WardenHelper

  def index
    @title = params[:title]
    @series_pattern = params[:series_pattern]
    # puts "PARAMS title, series: " + @title.to_s + " " + @series_pattern.to_s + " END"

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
    @exercise = evolution_ws(@title, @series_pattern)
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
      bottom_exercise.append({ 'title' => exercise[0].title, 'weight' => exercise[0].weight, 'series' => exercise[0].series })
    end
    bottom_exercise
  end

  def evolution_ws(title, series_pattern)
    if title.nil? or title == ''
      title = ExerciseNode
                .joins(:exercise)
                .where("exercises.user": current_user['id'])
                .where("exercise_nodes.weight != ''")
                .group("BTRIM(unaccent(lower(exercise_nodes.title)))")
                .select("COUNT(*) as count, BTRIM(unaccent(lower(exercise_nodes.title))) as title")
                .order("count DESC")
                .limit(1)
      title = title[0].title
    else
      title = title.downcase
    end

    if series_pattern == "s"
      series = "(LEFT(series, position('x' in series) - 1)::decimal) as series"
    elsif series_pattern == "r"
      series = "(RIGHT(series, length(series) - position('x' in series))::decimal) as series"
    else
      series = "(LEFT(series, position('x' in series) - 1)::decimal * RIGHT(series, length(series) - position('x' in series))::decimal) as series"
    end

    # puts "Before searching title: " + title.to_s + " " + series_pattern.to_s
    exercise = ExerciseNode
                 .joins(:exercise)
                 .where("exercises.user": current_user['id'])
                 .where("exercise_nodes.weight != ''")
                 .where("exercise_nodes.series LIKE '_x%'")
                 .where("BTRIM(unaccent(lower(exercise_nodes.title))) like BTRIM(unaccent(?))", title)
                 .order("exercise_nodes.created_at DESC")
                 .select("exercise_nodes.title, exercise_nodes.weight, " + series.to_s)
                 .limit(100)

    { 'title' => exercise[0].title,
      'weights' => Hash[(0...exercise.size).zip exercise.map(&:weight)],
      'series' => Hash[(0...exercise.size).zip exercise.map(&:series)] }
  end
end
