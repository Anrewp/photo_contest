ActiveAdmin.register User do
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
# permit_params :name, :email, :id, :provideri, :admin, :avatar, :created_at, :updated_at



filter :id
filter :name
filter :email
filter :provider
filter :admin

index do
  column :id
  column do |user|
  	link_to (image_tag user.image_url if user.image_url?), admin_user_path(user.id)
  end
  column :name do |user|
  	link_to user.name, admin_user_path(user.id)
  end
  column :email
  column :provider
  column :admin
  column do |user|
  	link_to 'DELETE',admin_user_path(user.id), method: :delete,
  	                                           data: { confirm: "You sure?" },
  	                                           class: "button"

  end
end

controller do

  def create
  	@user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else 
      flash[:error] = "email and provider can't be blanck"
      redirect_to new_admin_user_path
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :token, :provider, :admin)
  end
end

  show do
    attributes_table do
      row :avatar do
      	image_tag user.image_url if user.image_url?
      end
      row :id
      row :name
      row :email
      row :provider
      row :admin
    end


  end


sidebar 'Photos by this User', only: :show do
	
    table_for Photo.joins(:user).where(user_id: user.id)
                      .order('created_at DESC').limit(7) do |t|
      t.column("picture")  { |photo| link_to (image_tag photo.picture_url(:small)),
                                              admin_photo_path(photo.id)}
      t.column("Photo_id") { |photo| photo.id }
    end

end

config.per_page = 30

end