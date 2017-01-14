# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class NotesChannel < ApplicationCable::Channel
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
    ActionCable.server.broadcast 'notes_channel', message: 'random'
  end
end
