class User < ApplicationRecord
  has_many  :photos, dependent: :destroy
  has_many  :likes,  dependent: :destroy
  validates :email,    presence: true
  validates :provider, presence: true

  def User.from_omniauth(auth_hash)
    name = auth_hash['provider'] == 'vkontakte' ? "name" : "nickname"
    user = find_or_create_by(email: auth_hash.info.email, provider: auth_hash.provider)
    if user.name.blank?
     user.name = auth_hash.info.public_send(name)
     user.image_url = auth_hash.info.image
     user.token = auth_hash.credentials.token
    end
    user.save
    user
  end
end