class UsersController < ApplicationController
  def login
    user = User.where(nick: params[:user][:nick]).first
    if user
      session[:user] = user
    end
    redirect_to root_path
  end

  def register
    render
  end

  def create
    User.create(exercise_params)
    user = User.where(nick: params[:user][:nick]).first
    session[:user] = user
    redirect_to root_path
  end

  def logout
    session[:user] = nil
    redirect_to root_path
  end

  private

  def exercise_params
    params.require(:exercise).permit(:nick, :name, :email, :password)
  end

end
