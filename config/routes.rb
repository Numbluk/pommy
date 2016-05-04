Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root to: 'landing#index'

  resources :users, only: [:show, :new, :create] do
    collection do
      get :login
    end
  end

  resources :times, only: [:create] do
    collection do
      get :display
    end
  end
end
