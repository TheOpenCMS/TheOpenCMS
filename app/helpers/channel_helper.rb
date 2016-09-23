# http://stackoverflow.com/questions/39103685/can-you-invoke-jbuilder-to-create-a-native-rails-object-instead-of-a-rendered-st
module ChannelHelper
  def broadcast(channel, message)
    ActionCable.server.broadcast(channel, message)
  end

  def render_view(args)
    ApplicationController.render(args)
  end

  def render_json(args)
    JSON.parse render_view(args)
  end
end
