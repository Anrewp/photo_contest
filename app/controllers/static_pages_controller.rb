class StaticPagesController < ApplicationController
  def home
  	if current_user
  	  @photos = PHOTO_LIKE_COUNT.leaders(params[:page].to_i || 1, with_member_data: true)
      @paginate_array = Kaminari.paginate_array(@photos, total_count: PHOTO_LIKE_COUNT.total_members).page(params[:page])
  	end
  end

  def index; end
  def about; end
end
