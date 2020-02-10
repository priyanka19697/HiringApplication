class DashboardController < ApplicationController
  before_action :authenticate
  def index
    if current_user.role.name == "HIRING MANAGER"
      redirect_to manager_path
    else
      redirect_to interviewer_path
    end
    session[:role] = current_user.role.name
  end

  def show
  end
end
