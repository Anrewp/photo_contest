class LikesController < ApplicationController

  def create
    @photo = find_photo!(params)
    inputs = { photo: @photo, user_id: current_user.id }
               .reverse_merge(params)
    CreateLike.run!(inputs)
  end

  def destroy
    @photo = find_photo!(params)
    inputs = { like: FindLike.run!(params), user_id: current_user.id }
               .reverse_merge(params)
    DestroyLike.run!(inputs)
  end
end
