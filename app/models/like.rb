class Like < ApplicationRecord
  belongs_to    :photo
  belongs_to    :user
  after_save    :update_photo
  after_destroy :update_photo

private
  def update_photo
    photo.update_leaderboard
  end
end
