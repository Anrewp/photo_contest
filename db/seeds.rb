# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create!(email:                 'admin@example.com', 
	              password:              ENV['ADMIN_PASSWORD'], 
	              password_confirmation: ENV['ADMIN_PASSWORD'])

# User.create!(name:      "Example User",
# 	         email:     "exampleuser@mail.ru",
# 	         provider:  "vkontakte",
# 	         image_url: "https://cdn1.vectorstock.com/i/1000x1000/98/45/cartoon-funny-monster-face-avatar-vector-16149845.jpg"
# 	         )
# User.create!(name:      "Example User2",
# 	         email:     "exampleuser2@mail.ru",
# 	         provider:  "vkontakte",
# 	         image_url: "https://cdn1.vectorstock.com/i/1000x1000/98/45/cartoon-funny-monster-face-avatar-vector-16149845.jpg"
# 	         )

# 12.times do
# u = Photo.create(
# 	name: "Picture",
# 	user_id: User.try(:first).id,
# 	picture: Rails.root.join("app/assets/images/background.jpg").open,
#     state: "verified"
# 	)
# u.save
# end