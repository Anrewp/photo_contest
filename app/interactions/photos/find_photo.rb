class FindPhoto < ActiveInteraction::Base
  integer :photo_id, :id, default: nil

  def execute
    photo = Photo.find_by_id(photo_id || id)
    if photo
      photo
    else
      errors.add(:id, 'does not exist')
    end
  end
end