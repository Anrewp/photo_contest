class ListPhotosHome < ActiveInteraction::Base
  integer :page, default: nil

  def execute
   photos = PHOTO_LIKE_COUNT.leaders(page || 1, with_member_data: true)
   Kaminari.paginate_array(photos, total_count: PHOTO_LIKE_COUNT.total_members)
  end
end