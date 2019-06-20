class PhotosController < ApplicationController
  before_action :set_photo, except: [:index, :create]

  def index
    @paginate_array = SearchPhotos.run!(params).page(params[:page])
  end
 
  def show 
    if photo_verified?(@photo)
      @user = User.find(@photo.user_id)
    else redirect_to root_path
    end
  end

  def edit
    unless user_photo?(@photo)
      redirect_to root_path 
    end
  end

  def destroy
    if user_photo?(@photo)
      DestroyPhoto.run!(photo: @photo) 
    else redirect_to root_path
    end
  end

  def create
    inputs = { user_id: current_user.id }.reverse_merge(params[:photo])
    outcome = CreatePhoto.run(inputs)
    if outcome.valid?
      @user_photos = current_user.photos.order('created_at DESC')
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

private

  def set_photo
    @photo = Photo.find_by_id(params[:id])
  end
end
