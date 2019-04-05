class Photo < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PhotoUploader
  validate :picture_size

private

  def picture_size
    if picture.size > 5.megabytes
    	errors.add(:picture, "Photo should be less than 5MB")
    end
  end
end
