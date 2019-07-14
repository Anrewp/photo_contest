class Api::V1::ApiController < ActionController::Base
  protect_from_forgery with: :exception

private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    # jwt = cookies.signed[:jwt]
    begin
      # @decoded = JsonWebToken.decode(jwt)
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  helper_method :current_user
end