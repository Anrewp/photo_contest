class Api::V1::PhotosController < Api::V1::ApiController
  before_action :authorize_request

  def index
    @paginate_array = SearchPhotos.run!(params).page(params[:page])
    render json: @paginate_array, each_serializer: LeaderSerializer, status: :ok
  end
end