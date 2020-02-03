class ApplicationController < ActionController::Base
  helper :all
  def authenticate
  	redirect_to :login unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # session[:user_name] = @current_user.name
  end

  def user_signed_in?
  	# converts current_user to a boolean by negating the negation
  	!!current_user
  end

end
