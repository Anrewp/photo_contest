module PhotosHelper
# def fetch_photos_redis
#   photos = $redis.get("photos")  #This line requests redis-server to accepts any value associate with articles key
#   if photos.nil?  #this condition will executes if any articles not available on redis server
#     photos = Photo.verified.order("(select count(*) from likes where likes.photo_id = photos.id) desc, created_at desc").to_json   
#     $redis.set("photos", photos)
#     $redis.expire("articles",1.hour.to_i)
#   end
#   JSON.load photos #This will converts JSON data to Ruby Hash
# end
end
