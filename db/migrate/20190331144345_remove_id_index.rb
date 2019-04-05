class RemoveIdIndex < ActiveRecord::Migration[5.2]
  def change
  	change_column_null :users, :email, false
  	remove_index "users", name: "index_users_on_provider_and_id"
  	add_index :users, [:provider, :email], unique: true
  end
end
