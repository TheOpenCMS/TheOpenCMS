require 'sidekiq/web'

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == Settings.sidekiq.ui.password
end

Rails.application.routes.draw do
  mount Sidekiq::Web => '/async/tasks'
  mount ActionCable.server => '/app-cable'

  root to: "notes#index"

  devise_for :users
  resources  :notes

  get '/search' => 'search#search', as: :search
end

# For details on the DSL available within this file,
# see http://guides.rubyonrails.org/routing.html
