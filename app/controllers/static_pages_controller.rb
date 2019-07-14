class StaticPagesController < ApplicationController
  def home
    @paginate_array = ListPhotosHome.run(page: params[:page]).result
                        .page(params[:page])
  end

  def index; end
  def about; end
end
