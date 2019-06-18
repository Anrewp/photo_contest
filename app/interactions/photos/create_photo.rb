class CreatePhoto < ActiveInteraction::Base
  object  :picture, class: ActionDispatch::Http::UploadedFile
  string  :name
  integer :user_id

  validates :picture, presence: true
  validates :name, length: { maximum: 70 }
  validate  :picture_name
  validate  :picture_size

  def execute
    user = User.find_by_id(user_id)
    photo = user.photos.create(picture: picture, name: name)
    
    unless photo.save
      errors.merge!(photo.errors)
    end

    photo
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

# validates      :picture,    presence: true
#   validates      :name,       length: { maximum: 70 }
#   validate       :picture_name
#   validate       :picture_size
# private

#   def picture_size
#     if picture.size > 5.megabytes
#       errors.add(:picture, "Photo should be less than 5MB")
#     end
#   end

#   def picture_name
#     if name.blank?
#       errors.add(:name, "Photo title can't be blank!")
#     end
#   end