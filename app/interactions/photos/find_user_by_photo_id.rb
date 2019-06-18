class FindUserByPhotoId < ActiveInteraction::Base
  integer :id

  def execute
    photo = Photo.find_by_id(id)
    if photo
      user = User.find_by_id(photo.user_id)
      if user
        user
      else
      	errors.add(:user_id, 'does not exist')
      end
    else
      errors.add(:id, 'does not exist')
    end
  end
end