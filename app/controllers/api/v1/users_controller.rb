class Api::V1::UsersController < Api::V1::ApiController
  before_action :authorize_request, except: :user_token

  def info
  	render json: @current_user, status: :ok
  end

  def photos
  	render json: @current_user, serializer: UserPhotosSerializer, status: :ok
  end

  def user_token
    if current_user
      render json: JsonWebToken.encode(user_id: current_user.id), status: :ok
    end
  end
end