class FindLike < ActiveInteraction::Base
  integer :id, :photo_id

  def execute
    photo = Photo.find_by_id(photo_id)
    like = photo.likes.find(id)
    if like
      like
    else
      errors.add(:id, 'does not exist')
    end
  end
end