class UsersController < ApplicationController
  def login
    user = User.where(email: params[:user][:email]).first
    session[:user] = user
    # puts user.to_s + user[:email].to_s
    redirect_to root_path
  end

  def register
    User.create(email: params[:user][:email])
    user = User.where(email: params[:user][:email]).first
    session[:user] = user
    # puts user.to_s + user[:email].to_s
    redirect_to root_path
  end
end
