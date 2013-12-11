class UsersController < ApplicationController
  #before_action :authenticate_user!
  def index
    @users = User.order(created_at: :desc).limit(10)
  end
end
