class CreateComment < ActiveInteraction::Base
  string     :content
  integer    :user_id
  integer    :comment_id, :photo_id , default: nil
  validates  :content,  presence: true

  def execute
    commentable = if comment_id
                     Comment.find_by_id(comment_id)
                  else
                     Photo.find_by_id(photo_id)
                  end
    if commentable
      comment = commentable.comments.create(content: content,
                                            user_id: user_id)

      unless comment.save
        errors.merge!(comment.errors)
      end

      comment
    else
      errors.add(:id, 'does not exist')
    end
  end
end