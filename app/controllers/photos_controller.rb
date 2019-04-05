class PhotosController < ApplicationController

  before_action :set_photo, only: [:show, :destroy]
 
  def index
    @photo = Photo.order('created_at DESC')
  end
 
  def new ;end
  def show ;end
  def edit ;end
 
 
  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to photos_path
      flash[:success] = "Photo Created"
    else
      flash.now[:danger] = @photo.errors.details[:picture][0].values
      render :new
    end
  end
 
 
  def update
    if @photo.update_attributes(photo_params)
      redirect_to photo_path(@photo)
    else
      render :edit
      falsh.now[:danger] = "Something whent wrong!"
    end
  end

  def destroy
  	@photo.destroy
  	flash[:success] = "Photo deleted"
  	redirect_to photos_path
  end
 
  private
 
  def photo_params
    params.require(:photo).permit(:picture)
  end
 
  def set_photo
    @photo = Photo.find(params[:id])
  end
end
