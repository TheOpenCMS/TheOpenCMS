class NotesRandomWorker
  include Sidekiq::Worker

  def perform(*args)
    ActionCable.server.broadcast 'notes_channel', message: :random
  end
end
