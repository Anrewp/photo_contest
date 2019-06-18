class DestroyPhoto < ActiveInteraction::Base
  object :photo

  def execute
    photo.destroy
    PHOTO_LIKE_COUNT.remove_member(photo.id.to_s)
  end
end