Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
  }
  root 'posts#index'
  get 'posts/followings'
  post 'posts/liked_users'
  post 'comments/switch'
  resources :posts, only: [:create]
  resources :comments, only: [:create]
  resources :users, only: [:show]
  resources :user_relations, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
