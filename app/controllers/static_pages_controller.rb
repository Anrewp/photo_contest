class StaticPagesController < ApplicationController
  def home
  	if current_user
  	  @photo = Photo.verified.order("(select count(*) from likes where likes.photo_id = photos.id) desc, created_at desc")
  	end
  end

  def index; end
  def about; end
end
