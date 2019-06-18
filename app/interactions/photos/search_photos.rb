class SearchPhotos < ActiveInteraction::Base
  string :search
  string :reverse

  def execute
    photos = PHOTO_LIKE_COUNT.all_leaders(with_member_data: true)
    photos.reverse! if reverse == "true"

    photos.select! do |photo|
      JSON.parse(photo[:member_data])['name'].downcase.include?(search.downcase)
    end
    Kaminari.paginate_array(photos, total_count: photos.length)
  end
end