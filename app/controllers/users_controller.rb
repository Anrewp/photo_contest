class UsersController < ApplicationController
  before_action :current_user?, only: [:show, :edit]

  def edit
    @user = User.find(current_user.id)
  end

  def update
  	@user = User.find(current_user.id)
  	@user.name      = params[:user][:name]
  	@user.image_url = params[:user][:image_url]
  	if @user.save
  		flash[:success] = "User Updeated successfully!"
  		redirect_to @user
  	else
  		flash.now[:danger] = "Something whent wrong!"
  		render :edit
  	end
  end

  def show
    @user_photos = current_user.photos.order('created_at DESC').page(params[:page]).per(9)
  end

 private

  def user_params
    params.require(:user).permit(:name, :image_url)
  end

  def current_user?
   redirect_to root_path if !current_user
  end
end
