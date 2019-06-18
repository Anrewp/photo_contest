class Photo < ApplicationRecord
  include PhotoStateMachine
  mount_uploader :picture, PhotoUploader
  belongs_to     :user
  has_many       :likes, dependent: :destroy
  has_many       :comments, as: :commentable, dependent: :destroy

  scope :unmoderated, ->{ where(state: :unmoderated)}
  scope :published,   ->{ where(state: :verified)}
  scope :rejected,    ->{ where(state: :rejected)}
end
