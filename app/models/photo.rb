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

  	event :reject, after: [:remove_leaderboard_memeber, :destroy_photo] do
    	transitions from: [:unmoderated,:verified], to: :rejected
  	end

  	event :confirm, after: [:update_leaderboard, :cencel_destroy] do
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

  def destroy_photo
    PhotoDeleteWorker.perform_at(1.minutes.from_now, id)
  end

  def cencel_destroy
    queue = Sidekiq::ScheduledSet.new
    queue.each do |job|
      job.delete if job.args[0].equal?(id)
    end
  end
end
