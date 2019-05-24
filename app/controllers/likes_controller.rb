class LikesController < ApplicationController
  before_action :find_photo
  before_action :find_like, only: [:destroy]
  
  def create
   if liked?
     flash.now[:danger] = "You can't like more than once"
   else
    @photo.likes.create(user_id: current_user.id)
    respond_to do |format|
      format.js
    end
   end
  end

  def destroy
    if !liked?
      flash.now[:notice] = "Cannot unlike"
    else
      @like.destroy
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def liked?
    Like.where(user_id: current_user.id, photo_id:
    params[:photo_id]).exists?
  end

  def find_photo
    @photo = Photo.find(params[:photo_id])
  end

  def find_like
   @like = @photo.likes.find(params[:id])
  end
end
