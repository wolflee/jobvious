class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    # jobs I posted w/ applications
    @jobs = Job.includes(:applications).where(user_id: current_user.id).order(updated_at: :desc)
    # applications I submitted w/ the job
    @applications = Application.includes(:job).where(user_id: current_user.id)
  end
end
