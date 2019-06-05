class Like < ApplicationRecord
  belongs_to    :photo
  belongs_to    :user
  after_save    :update_photo, if: :photo_verified?
  after_destroy :update_photo, if: :photo_verified?

private
  def update_photo
    photo.update_leaderboard
  end

  def photo_verified?
    photo.verified?
  end
end
