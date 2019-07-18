class StaticPagesController < ApplicationController
  def home
    outcome = ListPhotosHome.run(page: params[:page])
    if outcome.valid?
      @paginate_array = outcome.result.page(params[:page])
    else
      flash[:danger] = outcome.errors.full_messages.to_sentence
      redirect_to root_path
    end
  end

  def index; end
  def about; end
end
