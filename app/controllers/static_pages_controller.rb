class StaticPagesController < ApplicationController
  def home
  	if current_user
  		redirect_to photos_index_path
  	end
  end
  def index; end
  def about; end
end
