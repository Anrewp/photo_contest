class Photo < ApplicationRecord
  include AASM
  belongs_to     :user
  has_many       :likes,      dependent: :destroy
  mount_uploader :picture,    PhotoUploader
  validates      :picture,    presence: true
  validates      :name,       length: { maximum: 70 }
  validate       :picture_name
  validate       :picture_size

  scope :unmoderated, ->{ where(state: :unmoderated)}
  scope :published,   ->{ where(state: :verified)}
  scope :rejected,    ->{ where(state: :rejected)}

	aasm column: 'state' do
  	state :unmoderated, initial: true
  	state :rejected
  	state :verified

  	event :reject do
    	transitions from: [:unmoderated,:verified], to: :rejected
  	end

  	event :confirm do
    	transitions from: [:unmoderated,:rejected], to: :verified
  	end

  end


private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "Photo should be less than 5MB")
    end
  end

  def picture_name
    if name.blank?
      errors.add(:name, "Photo title can't be blank!")
    end
  end
end
