class StaticPagesController < ApplicationController
  def home
  	if current_user
  	  @photo = PHOTO_LIKE_COUNT.leaders(params[:page].to_i || 1, with_member_data: true)
      @paginate_array = Kaminari.paginate_array(@photo, total_count: PHOTO_LIKE_COUNT.total_members).page(params[:page]).per(12)
  	end
  end

  def index; end
  def about; end
end
