class UsersController < ApplicationController
  def new ; end

  def edit
    if current_user 
      @user = User.find(current_user.id)
    else redirect_to root_path
    end
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
    if current_user
      @userphotos = current_user.photos.order('created_at DESC')
    else redirect_to root_path
    end
  end

 private

  def user_params
    params.require(:user).permit(:name, :image_url)
  end
end
