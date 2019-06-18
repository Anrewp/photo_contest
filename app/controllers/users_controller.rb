class UsersController < ApplicationController

  def edit
    @user = find_user!
  end
  
  def show
    @user_photos = ListUserPhotos.run!(user: current_user)
                     .page(params[:page]) 
  end

  def update
    inputs = { user: find_user! }.reverse_merge(params[:user])
    outcome = UpdateUser.run(inputs)
    if outcome.valid?
      flash[:success] = "User Updeated successfully!"
      redirect_to(outcome.result)
    else
      @user = outcome.user
      render 'edit'
    end
  end

private

  def find_user!
    outcome = FindUser.run(id: current_user.id)
    if outcome.valid?
      outcome.result
    else
      fail ActiveRecord::RecordNotFound, outcome.errors.full_messages.to_sentence
    end
  end
end
