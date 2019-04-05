class User < ApplicationRecord
  has_many :photos

  def User.from_omniauth(auth_hash)
    name = auth_hash['provider'] == 'vkontakte' ? "name" : "nickname"
    user = find_or_create_by(email: auth_hash.info.email, provider: auth_hash.provider)
    user.name = auth_hash.info.public_send(name)
    user.image_url = auth_hash.info.image
    user.token = auth_hash.credentials.token
    user.save!
    user
  end
end