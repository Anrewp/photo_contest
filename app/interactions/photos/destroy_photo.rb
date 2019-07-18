class DestroyPhoto < ActiveInteraction::Base
  object :photo

  def execute
   if  photo.destroy
    PHOTO_LIKE_COUNT.remove_member(photo.id.to_s)
   else
   	errors.add(:base, message: 'Something went wrong')
   end
  end
end