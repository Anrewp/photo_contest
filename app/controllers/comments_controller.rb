class CommentsController < ApplicationController
  
  def create
    params.permit!
    inputs = params[:comment].reverse_merge(params)
    CreateComment.run!(inputs)
    @photo = Photo.find(inputs[:photo_id])
  end

  def destroy
    comment = Comment.find_by_id(params[:id])
    comment.destroy
    @photo = Photo.find(params[:photo_id])
  end
end
