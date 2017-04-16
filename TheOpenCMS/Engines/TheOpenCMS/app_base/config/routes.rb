require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == Settings.sidekiq.ui.user && password == Settings.sidekiq.ui.password
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/async/tasks'
  mount ActionCable.server => '/app-cable'

  voiceless { ::UserRoom::Routes.mixin(self) }
end
