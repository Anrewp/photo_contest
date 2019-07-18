class CommentsController < ApplicationController
  
  def create
    params.permit!
    inputs = params[:comment].reverse_merge(params)
    outcome = CreateComment.run(inputs)
    if outcome.valid?
      @photo = Photo.find(inputs[:photo_id])
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
      redirect_to root_path
    end
  end

  def destroy
    comment = Comment.find_by_id(params[:id])
    comment.destroy
    @photo = Photo.find(params[:photo_id])
  end
end
