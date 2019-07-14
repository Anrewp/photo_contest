class Api::V1::UsersController < Api::V1::ApiController
  before_action :authorize_request, except: :user_token

  def user_info
  	render json: User.find(params[:id]), status: :ok
  end

  def user_photo
  	photo = User.find(params[:id]).photos.find(params[:photo_id])
  	render json: photo, status: :ok
  end

  def user_photos
  	render json: User.find(params[:id]), serializer: UserPhotosSerializer, status: :ok
  end

  def user_token
    if current_user
      render json: JsonWebToken.encode(user_id: current_user.id), status: :ok
    end
  end
end