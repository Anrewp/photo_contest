Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['VKONTAKTE_KEY'], ENV['VKONTAKTE_SECRET']
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']

end
