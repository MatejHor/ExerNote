class UsersController < ApplicationController
  def login
    user = User.where(email: params[:user][:email]).first
    if user
      session[:user] = user
    end
    redirect_to root_path
  end

  def register
    render
  end

  def create
    User.create(email: params[:user][:email])
    user = User.where(email: params[:user][:email]).first
    session[:user] = user
    redirect_to root_path
  end

  def logout
    session[:user] = nil
    redirect_to root_path
  end

end
