# def find_commentable
#     if params[:comment_id]
#       @commentable = Comment.find_by_id(params[:comment_id]) 
#     elsif params[:photo_id]
#       @commentable = Photo.find_by_id(params[:photo_id])
#     end
#   end

#     |
#     V

# def find_commentable!
#     outcome = FindCommentable.run(params)
#     if outcome.valid?
#       outcome.result
#     else
#       fail ActiveRecord::RecordNotFound, outcome.errors.full_messages.to_sentence
#     end
#   end

class FindCommentable < ActiveInteraction::Base
  integer :comment_id, :photo_id , default: nil

  def execute
    commentable = if comment_id
                     Comment.find_by_id(comment_id)
                  else
                     Photo.find_by_id(photo_id)
                  end

    if commentable
      commentable
    else
      errors.add(:id, 'does not exist')
    end
  end
end