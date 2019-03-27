class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :token
      t.string :provider, null: false
      t.string :image_url

      t.timestamps
    end

    add_index :users, :provider
    add_index :users, :id
    add_index :users, [:provider, :id], unique: true
  end
end
