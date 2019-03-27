Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['VKONTAKTE_KEY'], ENV['VKONTAKTE_SECRET']
end
