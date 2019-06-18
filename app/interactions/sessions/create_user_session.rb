class CreateUserSession < ActiveInteraction::Base
 string :auth

  validate :email? 
  validate :provider?

  def execute
  	hash = JSON.parse(auth)
    user = User.find_or_create_by(email:    hash['info']['email'],
                                  provider: hash['provider'])
    if user.name.blank?
      user.name      = hash['info']['nickname'] || hash['info']['name']
      user.image_url = hash['info']['image_url']
      user.token     = hash['credentials']['token']
    end

    unless user.save
      errors.merge!(user.errors)
    end

    user
  end

private
  def email?
  	hash = JSON.parse(auth)
  	hash['info']['email'] != ""
  end

  def provider?
  	hash = JSON.parse(auth)
  	hash['provider'] != ""
  end
end