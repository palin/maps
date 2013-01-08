Reporter::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
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
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    # resources :products
  end

  resources :events

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

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
