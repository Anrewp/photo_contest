class Api::V1::UsersController < Api::V1::ApiController
  before_action :authorize_request

  def user_info
  	render json: current_user, status: :ok
  end

  def user_photo
  	photo = current_user.photos.find(params[:id])
  	render json: photo, status: :ok
  end

  def user_photos
  	render json: current_user, serializer: UserPhotosSerializer, status: :ok
  end
end