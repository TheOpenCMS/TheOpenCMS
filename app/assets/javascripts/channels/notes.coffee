App.notes = App.cable.subscriptions.create "NotesChannel",
  connected: ->
    console.log 'NotesChannel connected'
    # Called when the subscription is ready for use on the server

  disconnected: ->
    console.log 'NotesChannel disconnected'
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log data
    console.log 'NotesChannel received'
    # Called when there's incoming data on the websocket for this channel

  random: ->
    @perform 'random'
