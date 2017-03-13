require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == Settings.sidekiq.ui.user && password == Settings.sidekiq.ui.password
end

# For details on the DSL available within this file,
# see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  mount Sidekiq::Web => '/async/tasks'
  mount ActionCable.server => '/app-cable'

  voiceless { ::UserRoom::Routes.mixin(self) }
end
