class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :destroy, :edit, :update]

  def index
    @paginate_array = ListPhotos.run!(params).page(params[:page])
  end
 
  def show 
    @user = FindUserByPhotoId.run!(params) if photo_verified?(@photo)
  end

  def edit
    user_photo?(@photo)
  end

  def destroy
    DestroyPhoto.run!(photo: @photo) if user_photo?(@photo)
  end

  def create
    inputs = { user_id: current_user.id }.reverse_merge(params[:photo])
    outcome = CreatePhoto.run(inputs)
    if outcome.valid?
      @user_photos = ListUserPhotos.run!(user: current_user)
                     .page(params[:page])
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
      redirect_to current_user
    end
  end

  def update
    inputs = { photo: @photo }.reverse_merge(params[:photo])
    outcome = UpdatePhoto.run(inputs)
    if outcome.valid?
      flash[:success] = "Photo Updeated successfully!"
      redirect_to current_user
    else
      flash.now[:danger] = "Something whent wrong!"
      render :edit
    end
  end

  def search
    @paginate_array = SearchPhotos.run!(params).page(params[:page])
  end

private

  def set_photo
    @photo = find_photo!(params)
  end
end
