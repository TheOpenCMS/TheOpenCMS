require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == Settings.sidekiq.ui.password
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/async/tasks'

  root to: "notes#index"

  devise_for :users
  resources  :notes
end

# For details on the DSL available within this file,
# see http://guides.rubyonrails.org/routing.html
