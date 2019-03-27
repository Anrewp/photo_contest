class User < ApplicationRecord
  def User.from_omniauth(auth_hash)
    user = find_or_create_by(name: auth_hash['info']['name'], provider: auth_hash['provider'])
    user.email = auth_hash['info']['email']
    user.image_url = auth_hash['info']['image']
    user.token = auth_hash['credentials']['token']
    user.save!
    user
  end
end
