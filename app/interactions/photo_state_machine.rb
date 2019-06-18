module PhotoStateMachine
  def self.included(base)
    base.send(:include, AASM)
    
    base.send(:aasm, column: 'state') do
  	  state :unmoderated, initial: true
  	  state :rejected
  	  state :verified

  	  event :reject, after: :remove_leaderboard_memeber do
    	  transitions from: [:unmoderated,:verified], to: :rejected
  	  end

  	  event :confirm, after: :update_leaderboard do
    	  transitions from: [:unmoderated,:rejected], to: :verified
  	  end
    end
  end

  def update_leaderboard
    PHOTO_LIKE_COUNT.rank_member(id.to_s, likes.count, { url: picture.url, 
                                                         medium_url: picture.medium.url,
                                                         name: name }.to_json)
  end

  def remove_leaderboard_memeber
    PHOTO_LIKE_COUNT.remove_member(id.to_s)
  end
end