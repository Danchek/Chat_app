Rails.application.routes.draw do
  root 'chat_rooms#index'
  resources :users, only: :show
  resources :friends, only: [:index, :destroy, :new]
  resources :friendship_requests, only: [:index, :update]
  post 'friendship_request/:id', to: 'friendship_requests#create',
       as: 'friendship_request_create'
  resources :chat_rooms do
    member do
      scope :user_add do
        post '/:friend_id', to: 'chat_rooms_users#create', as: 'create_user'
      end
    end
  end

  devise_for :users, controllers: {registrations: 'registrations'}
  scope :friends do
    get '/for_chat', to: 'chat_rooms_users#index', as: 'friends_for_chat'
  end


  mount ActionCable.server => '/cable'
end
