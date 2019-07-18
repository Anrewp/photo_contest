class Api::V1::PhotosController < Api::V1::ApiController
  before_action :authorize_request

  def index
    outcome = SearchPhotos.run(params)
    if outcome.valid?
      render json: outcome.result.page(params[:page]),
        each_serializer: LeaderSerializer, status: :ok
    else
      render json: outcome.errors.messages
    end
  end

  def show
  	photo = @current_user.photos.find(params[:id])
  	render json: photo, status: :ok
  end
end