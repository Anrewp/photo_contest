class CreateLike < ActiveInteraction::Base
  object  :photo
  integer :user_id

  def execute
    like = photo.likes.create(user_id: user_id) unless 
      Like.where(user_id: user_id, photo_id: photo.id).exists?
    if like.save
      if photo.verified?
        PHOTO_LIKE_COUNT.rank_member(photo.id.to_s, 
                                     photo.likes.count,
                                    { url:        photo.picture.url,
                                      medium_url: photo.picture.medium.url,
                                      name:       photo.name }.to_json)
      end
    else 
      errors.merge!(like.errors)
    end
    
    like
  end
end