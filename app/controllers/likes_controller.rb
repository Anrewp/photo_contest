class LikesController < ApplicationController
  before_action :find_photo

  def create
    inputs = { photo: @photo, user_id: current_user.id }
               .reverse_merge(params)
    CreateLike.run(inputs).result
  end

  def destroy
    inputs = { like: @photo.likes.find(params[:id]),
               user_id: current_user.id }
               .reverse_merge(params)
    DestroyLike.run(inputs).result
  end

private

  def find_photo
    @photo = Photo.find(params[:photo_id])
  end
end
