require 'sidekiq-scheduler'

class PhotoDeleteWorker
  include Sidekiq::Worker
  EXP_TIME = 2.hours #expiration time
  
  def perform
  	rejected_photos = Photo.rejected
  	rejected_photos.each do |photo|
  	  photo_expired = photo.updated_at + EXP_TIME
      unless DateTime.now.between?(photo.updated_at, photo_expired)
        photo.destroy
        PHOTO_LIKE_COUNT.remove_member(photo.id.to_s)
      end
  	end
  end
end