class Photo < ApplicationRecord
  include AASM
  belongs_to :user
  mount_uploader :picture, PhotoUploader
  validate :picture_size

	aasm column: 'state' do
  	state :unmoderated, initial: true
  	state :rejected
  	state :verified
  	state :published

  	event :reject do
    	transitions from: :unmoderated, to: :rejected
  	end

  	event :confirm do
    	transitions from: :unmoderated, to: :verified
  	end

  	event :publish do
    	transitions from: :verified, to: :published
  	end

  	event :discard do
    	transitions from: [:rejected, 
    										 :verified,
    										 :published], to: :unmoderated
  	end
  end


private

  def picture_size
  	if picture.size > 5.megabytes
    	errors.add(:picture, "Photo should be less than 5MB")
  	end
  end
end
