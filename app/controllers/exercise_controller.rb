class ExerciseController < ApplicationController
  def show
    @exercise_id = params[:id]
    render
  end

  def index
    require 'ostruct'
    @days = [OpenStruct.new(:date => "26.1.2020", :exercises => [OpenStruct.new(:id => 1, :title => "Cvicenie", :time => "21")])]
    render
  end

  def new
  end

  def create
    redirect_to root_path
  end
end
