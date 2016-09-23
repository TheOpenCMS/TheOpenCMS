class NotesRandomWorker
  include Sidekiq::Worker
  include ChannelHelper

  def perform(*args)
    broadcast 'notes_channel', render_json(
      layout: false,
      template: 'notes/ws_random.json.jbuilder',
      locals: { note: Note.random.first }
    )
  end
end
