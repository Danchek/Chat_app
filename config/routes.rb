Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :chat_rooms, only: [:new, :create, :show, :index]
  root 'chat_rooms#index'
end
