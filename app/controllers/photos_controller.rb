class PhotosController < ApplicationController

  before_action :set_photo, only: [:show, :destroy, :edit, :update]
 
  def index
    @photo = Photo.verified.order('created_at DESC')
  end
 
  def show 
   unless current_user && current_user.id.equal?(@photo.user_id) || @photo.verified?
     redirect_to root_path 
   else @user = User.find(@photo.user_id)
   end

  end

  def edit
    if current_user && current_user.id.equal?(@photo.user_id)
     return @photo 
    else redirect_to root_path
    end
  end
 
  def create
    if params[:photo]
      @photo = current_user.photos.build(photo_params)
      if @photo.save
        @userphotos = current_user.photos.order('created_at DESC')
        respond_to do |format|
          format.html { redirect_to current_user }
          format.js
        end
        # render 'create.js.erb'
      else
        flash[:danger] = @photo.errors.details[:name][0].values
        redirect_to current_user
      end
    else 
    end
  end

  def update
   if current_user && current_user.id.equal?(@photo.user_id)
     @photo.name = params[:photo][:name]
     if @photo.save
       flash[:success] = "Photo Updeated successfully!"
       redirect_to current_user
     else
       flash.now[:danger] = "Something whent wrong!"
       render :edit
     end
   else redirect_to root_path
   end
  end

  def destroy
    if current_user && current_user.id.equal?(@photo.user_id)
      @photo.destroy
      head :no_content
    end
  end
 
  private
 
  def photo_params
    params.require(:photo).permit(:picture,:name)
  end

 
  def set_photo
    @photo = Photo.find(params[:id])
  end
end
