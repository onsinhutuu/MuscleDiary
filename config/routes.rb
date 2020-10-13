Rails.application.routes.draw do
  get 'bigs/show'
	root 'homes#top'
		get 'homes/top' => 'homes#top'
		get 'homes/about' => 'homes#about'
  devise_for :admins,
   controllers: {
         sessions: 'admins/sessions',
         passwords: 'admins/passwords',
         registrations: 'admins/registrations',
  }
  devise_for :users,
     controllers: {
         sessions: 'users/sessions',
         passwords: 'users/passwords',
         registrations: 'users/registrations',
  }
   	devise_scope :user do
    	get '/users/sign_out' => 'devise/sessions#destroy'
  	end
	namespace :admins do
		resources :contacts, only: [:index, :edit, :update, :destroy]
	end
		get 'users/search' => 'searches#search'
		get '/muscle/hashtag/:name', to: "muscles#hashtag"
		resources :contacts, only: [:new, :create]
		resources :parts, only: [:new, :create]
		resources :bigs, only: [:show, :destroy]
		resources :muscles, only: [:show, :update, :edit, :index, :destroy, :create]do
			resources :muscle_comments, only: [:create, :destroy]
			resource :favorites, only: [:create, :destroy]
			resource :tags, only: [:index]
			get :following, on: :member
			get :workout, on: :member
 		end

		resources :users, only: [:show, :update, :edit] do
		    resource :relationships, only: [:create, :destroy]
		    get :follows, on: :member
		    get :followers, on: :member
		    patch :withdraw, on: :member
		    get :unsubscribe, on: :member
		end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
