Rails.application.routes.draw do
  root 'chat_rooms#index'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :chat_rooms, only: [:new, :create, :show, :index]
  mount ActionCable.server => '/cable'
end
