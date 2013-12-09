Reporter::Application.routes.draw do
  namespace :v1 do
    resources :reports, :only => [:show, :index, :update] do
      collection do
        post :send_report
      end
      resources :opinions, :only => [] do
        collection do
          get :all
          post :add
          get :can_vote
        end
        member do
          post :rate_up
          post :rate_down
          get :rating
        end
      end
      resources :abuses, :only => [] do
        collection do
          post :spam
          post :duplicate
          post :content
          post :solved
        end
      end
    end
  end

  namespace :v2 do
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
