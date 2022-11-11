Rails.application.routes.draw do
  root 'posts#index'
  get 'log-in', to: 'sessions#new'
  post 'log-in', to: 'sessions#create'
  delete 'log-out', to: 'sessions#destroy'
  resources :users, only: [:show, :create]
  resources :posts do
    member do
      get :publish
    end
  end
  get 'sign-up', to: 'users#new'
end
