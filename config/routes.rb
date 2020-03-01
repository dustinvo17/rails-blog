Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  get 'users/posts', to: 'users#posts'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'welcome', to: 'sessions#welcome'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :posts do
    resources :comments
  end
  resources :comments do
    resources :comments
  end
end
