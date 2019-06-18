class UpdateUser < ActiveInteraction::Base
  object :user

  string :name, :image_url,
    default: nil

  validates :name,
    presence: true,
    if: :name?
  validates :image_url,
    presence: true,
    if: :image_url?

  def execute
    user.name = name if name?
    user.image_url = image_url if image_url?

    unless user.save
      errors.merge!(user.errors)
    end

    user
  end
end