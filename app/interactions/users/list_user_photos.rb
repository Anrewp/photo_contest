class ListUserPhotos < ActiveInteraction::Base
  object  :user

  def execute
    user.photos.order('created_at DESC')
  end
end