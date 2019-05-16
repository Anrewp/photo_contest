class StaticPagesController < ApplicationController
  def home
  	if current_user
  	  @photo = Photo.verified.order('created_at DESC')
  	end
  end
  def index; end
  def about; end
end
