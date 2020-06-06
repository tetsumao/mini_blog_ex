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
  resources :posts, only: [:show, :create] do
    resources :likes, only: [:create, :destroy]
  end
  resources :comments, only: [:create]
  resources :users, only: [:show] do
    resources :user_relations, only: [:create, :destroy]
   end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
