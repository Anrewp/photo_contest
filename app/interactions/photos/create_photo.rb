class CreatePhoto < ActiveInteraction::Base
  object  :picture, class: ActionDispatch::Http::UploadedFile,
    default: nil

  string  :remote_picture_url, default: nil
  string  :name
  integer :user_id

  validates :picture,            presence: true, if: :picture?
  validates :remote_picture_url, presence: true, if: :remote_picture_url?
  validates :name,               length: { maximum: 70 }
  validate  :picture_name,                       if: :picture?
  validate  :picture_size,                       if: :picture?

  def execute
    user = User.find_by_id(user_id)
    if picture
      photo = user.photos.create(picture: picture, name: name)
      
      unless photo.save
        errors.merge!(photo.errors)
      end

      photo
    else
      photo = user.photos.create(remote_picture_url: remote_picture_url,
                                 name: name)
      
      unless photo.save
        errors.merge!(photo.errors)
      end

      photo
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