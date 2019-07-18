class DestroyLike < ActiveInteraction::Base
  object  :like
  integer :photo_id, :user_id

  def execute
   if Like.where(user_id:  user_id, photo_id: photo_id).exists?
     if like.destroy
       photo = Photo.find_by_id(photo_id)
       if photo.verified?
       PHOTO_LIKE_COUNT.rank_member(photo.id.to_s, 
                                    photo.likes.count,
                                  { url:        photo.picture.url,
                                    medium_url: photo.picture.medium.url,
                                    name:       photo.name }.to_json) 
       end
     else
      errors.add(:base, message: "Something went wrong!")
     end
   end
  end
end