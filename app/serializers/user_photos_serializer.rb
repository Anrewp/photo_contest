class UserPhotosSerializer < ActiveModel::Serializer
  attribute  :id, key: :user_id
  attributes :name
  attributes :user_photos
  
  def user_photos

  	self.object.photos.map do |photo| 
  	  @@counter = 0
  	  {
  	    photo_id:    photo.id,
  	    name:        photo.name,
  	    url:         photo.picture.url,
  	    medium_url:  photo.picture.medium.url,
  	    likes_count: photo.likes.count,
  	    # likes:       photo.likes.map do |like|
  	    #   {
  	    #     like_id: like.id,
  	    #     user_id: like.user_id
  	    #   }
  	    # end,
  	    # comments: photo.comments.map do |comment|
  	    #   @counter += 1
       #    comment_comments(comment)
  	    # end,
  	    comments_count: photo_comments(photo)
  	  }
  	end
  end

private

  def photo_comments(photo)
  	photo.comments.each do |comment|
      @@counter += 1
      comment_comments(comment)
    end
    @@counter
  end

  def comment_comments(comment)
  	 # {  
  	 # 	comment_id: comment.id,
  	 # 	comment_content: comment.content,
  	 #    comment_comments:  comment.comments.map do |comment|
  	 # 	   @counter += 1
  	 # 	   comment_comments(comment)
  	 #    end
  	 # }
  	 comment.comments.each do |comment|
  	   @@counter += 1
  	   comment_comments(comment)
  	 end
  end
end

