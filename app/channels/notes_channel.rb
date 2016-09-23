# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class NotesChannel < ApplicationCable::Channel
  include ChannelHelper

  def subscribed
    puts ">>> NotesChannel subscribed"
    stream_from "notes_channel"
  end

  def unsubscribed
    puts ">>> NotesChannel unsubscribed"
    # Any cleanup needed when channel is unsubscribed
  end

  def random
    puts ">>> NotesChannel random"

    broadcast 'notes_channel', render_json(
      template: 'notes/ws_random',
      locals: { note: Note.random.first }
    )
  end
end
