class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :provider,
             :image_url,
             :commented, 
             :liked, 
             :photos

  def commented
    self.object.comments.count    
  end

  def liked
    self.object.likes.count    
  end

  def photos
    self.object.photos.count    
  end
end
