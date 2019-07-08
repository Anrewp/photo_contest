class PhotoSerializer < ActiveModel::Serializer
  attribute  :id, key: :photo_id
  attributes :name, :url, :medium_url, :likes_count
  attributes :likes
  attributes :comments
  attributes :comments_count
  
  def url
    self.object.picture.url
  end

  def medium_url
    self.object.picture.medium.url
  end

  def likes_count
    self.object.likes.count
  end

  def likes
  	self.object.likes.map do |like|
  	  {
  	    like_id: like.id,
  	    user_id: like.user_id
  	  }
    end
  end

  def comments_count
  	@counter
  end

  def comments
  	@counter = 0
  	self.object.comments.map do |comment|
  	  @counter += 1
      comment_comments(comment)
  	end
  end

private

  def comment_comments(comment)
  	 {  
       user_id:          comment.user_id,
       comment_id:       comment.id,
       comment_content:  comment.content,
  	   comment_comments: comment.comments.map do |comment|
  	     @counter += 1
  	     comment_comments(comment)
  	   end
  	 }
  end
end