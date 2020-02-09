class ManagerController < ApplicationController
  def index
    @user_name = current_user.name
    return @user_name
 end
end
