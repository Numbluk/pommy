class InvitationsController < ApplicationController
  def create
    invitation = Invitation.new(user_id: params[:user_id], project_id: params[:project_id])

    if invitation.save
      respond_to do |format|
        format.js do
          @user = User.find(params[:user_id])
          render 'create'
        end
      end
    else

    end
  end

  def destroy
    respond_to do |format|
      format.js do
        @project = Project.find(params[:project_id])
        Invitation.delete(params[:id])

        if params[:accept] == 'true'
          @accept = true
          Stage.create(user: current_user, project: @project)
        end
        render layout: false
      end
    end
  end
end
