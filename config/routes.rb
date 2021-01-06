Rails.application.routes.draw do
  root 'homes#top'
  get 'homes/top' => 'homes#top'
  get 'homes/about' => 'homes#about'
  get 'homes/profile' => 'homes#profile'
  devise_for :admins,
             controllers: {
               sessions: 'admins/sessions',
               passwords: 'admins/passwords',
               registrations: 'admins/registrations'
             }
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               passwords: 'users/passwords',
               registrations: 'users/registrations'
             }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  devise_scope :admin do
    post 'admins/guest_sign_in', to: 'admins/sessions#guest_admin'
  end
  namespace :admins do
    resources :contacts, only: %i[index edit update destroy]
  end
  get 'users/search' => 'searches#search'
  resources :contacts, only: %i[new create]
  resources :parts, only: %i[new create]
  resources :bigs, only: %i[show destroy]
  resources :muscles, only: %i[show update edit index destroy create] do
    resources :muscle_comments, only: %i[create destroy]
    resource :favorites, only: %i[create destroy]
    resource :tags, only: [:index]
    get :following, on: :member
    get :workout, on: :member
  end
  get '/muscle/hashtag/:name', to: 'muscles#hashtag'

  resources :users, only: %i[show update edit] do
    resource :relationships, only: %i[create destroy]
    get :follows, on: :member
    get :followers, on: :member
    patch :withdraw, on: :member
    get :unsubscribe, on: :member
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
