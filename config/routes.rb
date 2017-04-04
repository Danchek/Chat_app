Rails.application.routes.draw do
  root 'chat_rooms#index'
  devise_for :users, controllers: {registrations: 'users/registrations'}
  resources :chat_rooms, only: [:new, :create, :show, :index]
  resources :users, only: :show

  scope :friends do
    get '/find', to: 'friendships#find', as: 'friends_find'
    get '', to: 'friendships#friends', as: 'friends'
    get '/pending_requests', to: 'friendships#pending_requests', as: 'friends_pending_requests'
    get '/user_request', to: 'friendships#user_request', as: 'friends_user_request'
  end
  scope :friend do
    patch '/update_request/:friend_id', to: 'friendships#change_request_status', as: 'friend_update_request'
    post '/add/:friend_id', to: 'friendships#add_friend', as: 'add_friend'
    delete '/remove/:friend_id', to: 'friendships#remove_friend', as: 'remove_friend'
  end

  mount ActionCable.server => '/cable'
end
