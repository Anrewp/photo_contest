class CommentsController < ApplicationController
  before_action :find_commentable, only: :create
  before_action :find_comment,     only: :destroy

  def new
    @comment = Comment.new
  end

  def create
    @commentable.comments.build(comment_params)
    if @commentable.save
      @photo = Photo.find(params[:comment][:id])
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    if @comment.destroy
       @photo = Photo.find(params[:photo_id])
      respond_to do |format|
        format.js
      end
    end
  end

private

  def comment_params
    params.require(:comment).permit(:content,:user_id)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find_by_id(params[:comment_id]) 
    elsif params[:photo_id]
      @commentable = Photo.find_by_id(params[:photo_id])
    end
  end

end
