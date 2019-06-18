class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def find_photo!(inputs)
    outcome = FindPhoto.run(inputs)
    if outcome.valid?
      outcome.result
    else
      fail ActiveRecord::RecordNotFound, outcome.errors.full_messages.to_sentence
    end
  end

  def photo_verified?(photo)
   if current_user && current_user.id.equal?(photo.user_id) || photo.verified?
    true
   else 
    false
    redirect_to root_path
   end
  end

  def user_photo?(photo)
   if current_user && current_user.id.equal?(photo.user_id)
    true
   else 
    false
    redirect_to root_path
   end
  end

  helper_method :current_user
end
