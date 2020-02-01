class DashboardController < ApplicationController
  before_action :authenticate
  def index
    if current_user.role.name == "HIRING MANAGER"
      redirect_to manager_path
    else
      redirect_to interviewer_path
    end
  end

  def show
  end
end
