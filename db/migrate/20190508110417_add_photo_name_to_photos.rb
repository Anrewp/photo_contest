class AddPhotoNameToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :name, :string
    remove_column :users, :admin
  end
end
