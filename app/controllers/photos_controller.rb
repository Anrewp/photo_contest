class PhotosController < ApplicationController

  before_action :set_photo,       only: [:show, :destroy, :edit, :update]
  before_action :user_photo?,     only: [:edit, :update, :destroy]
  before_action :photo_verified?, only: :show

  def index
    # @photo = Photo.verified.order("(select count(*) from likes where likes.photo_id = photos.id) desc, created_at desc").page(params[:page]).per(12)
    @photos = PHOTO_LIKE_COUNT.leaders(params[:page].to_i || 1, with_member_data: true)
    @paginate_array = Kaminari.paginate_array(@photos, total_count: PHOTO_LIKE_COUNT.total_members).page(params[:page])
  end

 
  def show 
    @user = User.find(@photo.user_id)
  end

  def edit
    @photo 
  end
 
  def destroy
    @photo.destroy
  end

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      @user_photos = current_user.photos.order('created_at DESC').page(params[:page])
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = @photo.errors.details[:name][0].values
        redirect_to current_user
    end
  end

  def update
     @photo.name = params[:photo][:name]
     if @photo.save
       flash[:success] = "Photo Updeated successfully!"
       redirect_to current_user
     else
       flash.now[:danger] = "Something whent wrong!"
       render :edit
     end
  end
 
private
 
  def photo_params
    params.require(:photo).permit(:picture,:name)
  end

  def user_photo?
    if current_user && current_user.id.equal?(@photo.user_id)
    else redirect_to root_path
    end
  end

  def photo_verified?
    if current_user && current_user.id.equal?(@photo.user_id) || @photo.verified?
    else redirect_to root_path
    end
  end
 
  def set_photo
    @photo = Photo.find(params[:id])
  end
end
