class PhotoDeleteWorker
  include Sidekiq::Worker

  def perform(id)
  	outcome = DestroyPhoto.run(photo: Photo.find(id)) 
    unless outcome.valid?
      outcome.errors.full_messages.to_sentence
    end
  end

end