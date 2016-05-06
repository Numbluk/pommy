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

  private

  def get_params
    params.require(:project).permit(:project_name)
  end
end
