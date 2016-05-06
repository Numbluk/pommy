class StagesController < ApplicationController
  before_action :logged_in?, only: :create

  def create
    @stage = Stage.new
      respond_to do |format|
        format.json do
          @stage.stage_type = params[:stage_type]
          @stage.user = current_user
          @stage.project = Project.find_by(project_name: current_project) if current_project
          @stage.save
          render nothing: true
        end
      end
  end

  def display; end
end
