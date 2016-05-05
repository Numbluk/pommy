class UsersController < ApplicationController
  before_action :send_to_profile, except: [:show]
  before_action :logged_in?, only: :show

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(get_params)

    if @user.save
      flash[:notice] = "You are now registered."
      redirect_to display_stages_path
    else
      render 'new'
    end
  end

  private

  def get_params
    params.require(:user).permit(:username, :password, :timezone)
  end

  def send_to_profile
    if logged_in?
      redirect_to user_path(current_user)
    end
  end
end
