# C H E C K     T H I S    F I L E    W I T H    A N     O L D E R      V E R S I O N
Rails.application.routes.draw do
 
  LOCALES = /en|pt\-BR/
  scope "(:locale)", locale: LOCALES do
    resource :confirmation, only: [:show]
    get "/404" => "errors#not_found"
    get "/422" => "errors#not_access"
    get "/500" => "errors#internal_server_error"

    namespace :user do
      resources :users
      resource :user_sessions, only: [:create, :new, :destroy]
      get 'user_sessions' => 'user_sessions#new'
    end

    namespace :team do
      resources :teams
    end

    namespace :comp do
      resources :competitions do
        get 'ranking'
        get 'add_teams'
        patch 'update_teams'
        put 'set_post_competition'
        put 'set_started_competition'
        resources :rounds, shallow: true do
          put 'set_round_done'
          resources :fixtures, shallow: true do
            get 'assign_fixture'
            patch 'update_assign_fixture'
            put 'set_fixture_done'
          end
        end
      end
    end

    namespace :pred do
      resources :predictions do
        get 'pred_rounds'
        get 'pred_fixtures'
        get 'pred_ranking'
        match 'predictions/round/assign' => 'predictions#assign_round', :as => :assign_round, :via => :get
        match 'predictions/round' => 'predictions#update_round', :as => :update_round, :via => :put
        get 'assign_fixtures'
      end
      resources :look do
        get 'look_fixtures', on: :collection
      end
    end

  end
  
  get '/:locale' => 'home#index', locale: LOCALES
  root 'home#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
