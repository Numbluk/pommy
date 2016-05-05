class LandingController < ApplicationController
  before_action :send_to_stages

  def index; end

  private

  def send_to_stages
    if logged_in?
      redirect_to display_stages_path
    end
  end
end
