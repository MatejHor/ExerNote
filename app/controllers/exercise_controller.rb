class ExerciseController < ApplicationController
  def show
    require 'ostruct'
    @days = [OpenStruct.new(:date => "26.1.2020", :exercises => [OpenStruct.new(:id => 1, :title => "Cvicenie", :time => "21")])]
    puts @days
    render
  end

  def index
  end
end
