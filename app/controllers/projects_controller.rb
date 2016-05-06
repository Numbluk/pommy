class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(get_params)
    @project.owner = current_user

    if @project.save
      flash[:notice] = 'Project successfully saved: ' + @project.project_name
      redirect_to user_path(current_user)
    else
      render 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def add_user
    @user = User.find(params[:user_id])
    @project = Project.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  private

  def get_params
    params.require(:project).permit(:project_name)
  end
end
