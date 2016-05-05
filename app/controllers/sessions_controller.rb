class SessionsController < ApplicationController
  before_action :send_to_profile, except: [:destroy]
  before_action :logged_in?, only: :destroy

  def new; end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to display_stages_path
    else
      flash[:error] = 'Incorrect user name or password.'
      redirect_to login_path
    end
  end

  def destroy
    flash[:notice] = 'You are now logged out.'
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def send_to_profile
    if logged_in?
      redirect_to user_path(current_user)
    end
  end
end
