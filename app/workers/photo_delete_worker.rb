require 'sidekiq-scheduler'

class PhotoDeleteWorker
  include Sidekiq::Worker
  EXP_TIME = 5.minutes #expiration time
  
  def perform
  	rejected_photos = Photo.rejected
  	rejected_photos.each do |photo|
  	  photo_expired = photo.updated_at + EXP_TIME
      photo.destroy unless DateTime.now.between?(photo.updated_at, photo_expired)
  	end
  end
end