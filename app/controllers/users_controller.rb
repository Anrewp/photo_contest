class UsersController < ApplicationController

  def edit
    @user = current_user
  end
  
  def show
    @user_photos = current_user.photos.order('created_at DESC')
                     .page(params[:page]) 
  end

  def update
    inputs = { user: current_user }.reverse_merge(params[:user])
    outcome = UpdateUser.run(inputs)
    if outcome.valid?
      flash[:success] = "User Updeated successfully!"
      redirect_to(outcome.result)
    else
      @user = outcome.user
      render 'edit'
    end
  end
end
