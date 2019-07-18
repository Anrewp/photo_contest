class LikesController < ApplicationController
  before_action :find_photo

  def create
    inputs = { photo: @photo, user_id: current_user.id }
               .reverse_merge(params)
    outcome = CreateLike.run(inputs)
    if outcome.valid?
      outcome.result
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
      redirect_to root_path
    end
  end

  def destroy
    inputs = { like: @photo.likes.find(params[:id]),
               user_id: current_user.id }
               .reverse_merge(params)
    outcome = DestroyLike.run(inputs)
    if outcome.valid?
      outcome.result
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
      redirect_to root_path
    end
  end

private

  def find_photo
    @photo = Photo.find(params[:photo_id])
  end
end
