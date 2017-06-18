Rails.application.routes.draw do
  root to: 'welcome#index'
  get :create_new, to: 'welcome#create_new'
end
