class InterviewerController < ApplicationController
  def index
     byebug
     @user_name = current_user.name
     return @user_name
  end
end
