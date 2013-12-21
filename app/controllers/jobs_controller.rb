class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_poster!, only: [:edit, :update, :destroy]

  def index
    @jobs = Job.all
  end

  def show
    @applied = @job.applications.find_by user_id: current_user.id if user_signed_in?
  end

  def new
    @job = Job.new
  end

  def edit
  end

  def create
    @job = current_user.jobs.new(job_params)
    if @job.save
      redirect_to @job, notice: 'Job was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_url
  end

  private
  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :location, :description, :contact, :company, :url)
  end

  def check_poster!
    redirect_to jobs_url, alert: "This job doesn't belong to you." unless @job.user == current_user
  end
end
