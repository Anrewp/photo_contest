class UpdatePhoto < ActiveInteraction::Base
  object :photo
  string :name, default: nil

  validates :name, presence: true, if: :name?

  def execute
    photo.name = name if name?

    unless photo.save
      errors.merge!(photo.errors)
    end

    photo
  end
end