class ExerciseNodesController < ApplicationController
  def add_node
    # Find Exercise by id
    exercise = Exercise.find(params[:id])

    # Create new node
    node = {
        "title" => params[:title],
        "weight" => params[:weight],
        "series" => params[:series]
    }

    # Append new node to json and save object
    exercise.exercises.push(node)
    exercise.save

    redirect_to exercise_path(params[:id])
  end

  def delete_node
    # Find Exercise by id
    exercise = Exercise.find(params[:id])
    new_json = []

    # Convet String into JSON
    json = ActiveSupport::JSON.decode exercise.exercises.to_s.gsub('=>', ':')

    # Add every node to new json, except one, which is equals to deleted
    json.each do |node|
      unless node['title'].eql? params[:title] and node['weight'].eql? params[:weight] and node['series'].eql? params[:series]
        new_json.push(node)
      end
    end

    # Replace old json with new json, and save object
    exercise.exercises = new_json
    exercise.save

    redirect_to exercise_path(params[:id])
  end
end
