Reporter::Application.routes.draw do

  namespace :v1 do
    resources :reports, only: [:create, :index, :show, :update] do
      resources :abuses, only: [:create]
      resources :opinions, only: [:create, :index, :show, :update]
    end
    resources :maps, :only => [] do
      collection do
        get :border
      end
    end
  end

  namespace :admin do
    root to: 'reports#index'
    get 'logout', to: 'user_sessions#destroy', as: :logout
    get 'login', to: 'user_sessions#new', as: :login
    resources :user_sessions, only: [:create]
    resources :reports
    resources :opinions
    resources :abuses
    resources :categories
  end

  root to: 'home#index'
end
