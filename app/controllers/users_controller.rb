class UsersController < ApplicationController
  def login
    login_user params[:user][:nick]
  end

  def register
    render
  end

  def create
    User.create(user_params)
    login_user params[:user][:nick]
    redirect_to root_path
  end

  def logout
    warden.logout
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nick, :name, :email, :password_digest)
  end

  def warden
    request.env['warden']
  end

  def login_user(nick)
    user = User.where(nick: nick).first
    if user
      warden.set_user(user)
      warden.authenticate!
    end
    redirect_to root_path
  end
end
