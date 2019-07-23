class Photo < ApplicationRecord
  require 'sidekiq/api'
  include AASM
  mount_uploader :picture, PhotoUploader
  belongs_to     :user
  has_many       :likes, dependent: :destroy
  has_many       :comments, as: :commentable, dependent: :destroy
  validates      :picture, presence: true
  validates      :name, length: { maximum: 70 }

  scope :unmoderated, ->{ where(state: :unmoderated)}
  scope :published,   ->{ where(state: :verified)}
  scope :rejected,    ->{ where(state: :rejected)}

  aasm column: 'state' do
  	state :unmoderated, initial: true
  	state :rejected
  	state :verified

  	event :reject, after: :remove_leaderboard_memeber do
    	transitions from: [:unmoderated,:verified], to: :rejected
  	end

  	event :confirm, after: :update_leaderboard do
    	transitions from: [:unmoderated,:rejected], to: :verified
  	end
  end

private

  def update_leaderboard
    PHOTO_LIKE_COUNT.rank_member(id.to_s, likes.count, { url: picture.url, 
                                                         medium_url: picture.medium.url,
                                                         name: name }.to_json)
  end

  def remove_leaderboard_memeber
    PHOTO_LIKE_COUNT.remove_member(id.to_s)
  end

end
