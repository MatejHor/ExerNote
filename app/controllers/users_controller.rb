class UsersController < ApplicationController
  def login
    login_user(params[:user][:nick], params[:user][:password])
  end

  def register
    render
  end

  def create
    User.create(user_params)
    login_user(params[:user][:nick], params[:user][:password])
  end

  def logout
    warden.logout
    redirect_to home_path
  end

  private

  def user_params
    params.require(:user).permit(:nick, :name, :email, :password)
  end

  def warden
    request.env['warden']
  end

  def login_user(nick, password)
    # user = User.where(nick: nick).first
    user = User.find_by(nick: nick)&.authenticate(password)
    if user
      warden.set_user(user)
      warden.authenticate!
      redirect_to root_path
    else
      # render(
      #   html: "<script>alert('Wrong username or password!')</script>".html_safe,
      # )
      # redirect_to root_path
      # format.html { redirect_to root_path, alert: 'Message sent!' }
      redirect_to home_path(:error => true)
    end
  end
end
