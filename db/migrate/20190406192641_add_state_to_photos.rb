class AddStateToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :state, :string
  end
end
