ActiveAdmin.register Photo do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
permit_params :user_id, :state, :picture

scope :all
scope :unmoderated
scope :published
scope :rejected

filter :state, as: :select
filter :user, as: :select

action_item :publish, only: :show do
	link_to "Publish", publish_admin_photo_path, style: 'color: #009A03;',method: :put if photo.unmoderated?
end

action_item :reject, only: :show do
	link_to "Reject", reject_admin_photo_path, style: 'color: #AF0000;', method: :put if photo.unmoderated?
end

member_action :publish, method: :put do
	photo = Photo.find(params[:id])
	photo.confirm!
	redirect_to admin_photos_path
end

member_action :reject, method: :put do
	photo = Photo.find(params[:id])
	photo.reject!
	redirect_to admin_photos_path
end

index do
  column :Photo do |photo|
   link_to (image_tag photo.picture_url(:small)), admin_photo_path(photo.id)
  end#.order('created_at DESC')
  column :State do |photo|
    photo.state
  end
  column :User do |photo|
    user = User.find(photo.user_id)
   link_to user.name, admin_user_path(user.id) 
  end

  actions defaults: false do |photo|
    item "Publish", publish_admin_photo_path(photo.id), style: 'color: #B2E8B3;',class: "button", method: :put if photo.unmoderated?
    item "Reject", reject_admin_photo_path(photo.id), style: 'color: #F8B5B5;',class: "button", method: :put if photo.unmoderated?
    item "Edit", edit_admin_photo_path(photo.id),class: "button"
    item "Delete", admin_photo_path(photo.id),style: 'color: #FF8686;',class: "button", method: :delete,data: { confirm: "You sure?" }
  end
    
end

show do

    attributes_table do
      row :user_name do |photo|
      	user = User.find(photo.user_id)
      	link_to user.name, admin_user_path(user.id) 
      end
      row :avatar do |photo|
      	user = User.find(photo.user_id)
      	link_to (image_tag user.image_url if user.image_url?), admin_user_path(user.id)
      end
      row :state
      row :photo do
      	image_tag photo.picture_url
      end
      row :created_at
      row :updated_at
    end
end

config.per_page = 9

end
