class Photo < ApplicationRecord
  include AASM
  belongs_to :user
  mount_uploader :picture, PhotoUploader
  validates :picture, presence: true
  validate :picture_size

  scope :unmoderated, ->{ where(state: :unmoderated)}
  scope :published, ->{ where(state: :verified)}
  scope :rejected, ->{ where(state: :rejected)}

	aasm column: 'state' do
  	state :unmoderated, initial: true
  	state :rejected
  	state :verified

  	event :reject do
    	transitions from: :unmoderated, to: :rejected
  	end

  	event :confirm do
    	transitions from: :unmoderated, to: :verified
  	end

  end


private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "Photo should be less than 5MB")
    end
  end
end
