class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def photo_verified?(photo)
    current_user && current_user.id.equal?(photo.user_id) || photo.verified?
  end

  def user_photo?(photo)
    current_user && current_user.id.equal?(photo.user_id)
  end

  helper_method :current_user
end
