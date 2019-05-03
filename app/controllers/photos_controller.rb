class PhotosController < ApplicationController

  before_action :set_photo, only: [:show, :destroy]
 
  def index
    @photo = Photo.verified.order('created_at DESC')
  end
 
  def show ; end
 
  def create
    if params[:photo]
      @photo = current_user.photos.build(photo_params)
      if @photo.save
        redirect_to photos_path
        flash[:success] = "Photo Created"
      else
        flash.now[:danger] = @photo.errors.details[:picture][0].values
        render :new
      end
    else render :new
    end
  end

  def destroy
    if current_user && current_user.id.equal?(@photo.user_id)
      @photo.destroy
      flash[:success] = "Photo deleted"
      redirect_to photos_path
    end
  end
 
  private
 
  def photo_params
    params.require(:photo).permit(:picture)
  end

 
  def set_photo
    @photo = Photo.find(params[:id])
  end
end
