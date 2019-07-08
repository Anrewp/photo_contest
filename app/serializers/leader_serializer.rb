class LeaderSerializer < ActiveModel::Serializer
  attributes :member, :rank, :score, :member_data

  def rank
    self.object[:rank]
  end

  def member
  	self.object[:member]
  end

  def score
  	self.object[:score]
  end
   
  def member_data
    {
   	  name: JSON.parse(self.object[:member_data])['name'],
   	  url:  JSON.parse(self.object[:member_data])['url'],
   	  medium_url: JSON.parse(self.object[:member_data])['medium_url']
   	}
  end
end