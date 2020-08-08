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
    User.create(user_params)
    user = User.where(nick: params[:user][:nick]).first
    session[:user] = user
    redirect_to root_path
  end

  def logout
    session[:user] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nick, :name, :email, :password)
  end

end
