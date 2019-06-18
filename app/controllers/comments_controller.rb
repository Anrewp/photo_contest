class CommentsController < ApplicationController
  
  def create
    inputs = { comment_id: params[:comment_id],
               photo_id:   params[:photo_id] }
               .reverse_merge(params[:comment])
    CreateComment.run!(inputs)
    @photo = find_photo!(params[:comment])
  end

  def destroy
    DestroyComment.run!(comment: FindComment.run!(params))
    @photo = find_photo!(params)
  end
end
