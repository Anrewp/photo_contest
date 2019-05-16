class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


private

  def authenticate_admin_user!
    # unless session[:user_id] && current_user.admin?
    #   redirect_to root_path
    # end
  end

  def current_admin_user
    # session[:user_id]
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  helper_method :current_user
end
