Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root to: 'landing#index'
  get 'about', to: 'landing#about'

  resources :users, only: [:show, :new, :create]

  resources :stages, only: [:create] do
    collection do
      get :display
    end
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
end
