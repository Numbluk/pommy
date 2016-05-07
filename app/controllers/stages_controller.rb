class StagesController < ApplicationController

  def create
    if logged_in?
      @stage = Stage.new
      respond_to do |format|
        format.json do
          @stage.stage_type = params[:stage_type]
          @stage.user = current_user
          @stage.project = Project.find_by(project_name: current_project) if current_project
          @stage.save
        end
      end
    end
    render nothing: true
  end

  def display; end
end
