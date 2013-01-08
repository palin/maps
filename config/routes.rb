Reporter::Application.routes.draw do
  namespace :api do
    resources :reports, :only => [] do
      collection do
        get :all
        post :send_report
      end
      member do
        post :rate_up
        post :rate_down
        post :can_vote
        get :rating
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

    resources :maps, :only => [] do
      collection do
        get :border
      end
    end
  end

  namespace :admin do
    root :to => 'reports#index'
    match 'logout', :to => 'user_sessions#destroy', :as => :logout
    match 'login', :to => 'user_sessions#new', :as => :login
    resources :user_sessions, :only => [:create]
    resources :reports
    resources :opinions
    resources :abuses
    resources :categories
  end

  root :to => 'home#index'
end
