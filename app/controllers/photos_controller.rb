class PhotosController < ApplicationController

  before_action :set_photo, only: [:show, :destroy, 
                                   :set_confirm, :set_reject,
                                   :set_publish,:set_discard]
 
  def index
    @photo = if current_user
      @photo = Photo.order('created_at DESC')
    else
      @photo = Photo.published.order('created_at DESC')
    end
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
 
  def set_confirm
    if @photo.unmoderated?
      @photo.confirm! 
      flash[:success] = "Verefied"
      redirect_to photo_path(@photo)
    else
      flash[:danger] = "Can't be verefied"
      redirect_to photo_path(@photo)
    end
  end

  def set_reject
    if @photo.unmoderated?
      @photo.reject! 
      flash[:success] = "Rejected"
      redirect_to photo_path(@photo)
    else
      flash[:danger] = "Can't be rejected"
      redirect_to photo_path(@photo)
    end
  end

  def set_publish
    if @photo.verified?
      @photo.publish! 
      flash[:success] = "Published"
      redirect_to photo_path(@photo)
    else
      flash[:danger] = "Can't be published"
      redirect_to photo_path(@photo)
    end
  end

  def set_discard
    if @photo.verified? || @photo.rejected? || @photo.published?
      @photo.discard! 
      flash[:success] = "Discarded"
      redirect_to photo_path(@photo)
    else
      flash[:danger] = "Can't be discarded"
      redirect_to photo_path(@photo)
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
