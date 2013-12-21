class ApplicationsController < ApplicationController
  before_action :set_job, only: [:new, :create]
  before_action :set_application, only: [:show, :destroy]
  before_action :authenticate_user!, except: :show
  before_action :check_authorization!, only: :show
  before_action :check_applicant!, only: :destroy

  def new
    redirect_to jobs_url, notice: 'This is a job you posted.' if @job.user == current_user
    @application = @job.applications.new
    @application.name = current_user.name || 'No Name'
  end

  def create
    # delete old application if exist
    outdated_application = @job.applications.find_by user_id: current_user
    if outdated_application
      outdated_application.remove_resume!
      outdated_application.destroy
    end

    @application = @job.applications.new(application_params)
    @application.user = current_user
    if @application.save
      redirect_to @job, notice: 'The application has been made.'
    else
      render action: 'new'
    end
  end

  def show
  end

  def destroy
    @applications.destroy
    redirect_to jobs_url
  end

  private
  def set_job
    @job = Job.find(params[:job_id])
  end

  def set_application
    @application = Application.find(params[:id])
  end

  def application_params
    params.require(:application).permit(:name, :email, :resume)
  end

  def check_authorization!
    redirect_to jobs_url, alert: "Only job poster can browse candidates." unless @application.job.user == current_user
  end

  def check_applicant!
    redirect_to @job, alert: "Only applicants can remove applications." unless @application.user == current_user
  end
end
