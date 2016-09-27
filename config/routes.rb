Rails.application.routes.draw do
  resources :churches_people
  resources :people
  resources :addresses
  resources :dioceses do
    resources :churches, shallow: true do
      collection do
        get 'map'
      end
    end
  end
  resources :renew_regions
  resources :patrons
  resources :users
  resources :churches do
    collection do
      get 'map'
    end
  end
  
  get 'dioceses/:diocese_name/map', to: "dioceses#map" 
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/:provider/callback_redirect', to: 'sessions#callback_redirect'
  get 'auth/failure', to: 'sessions#fail'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  post 'sign_in_as', to: 'sessions#sign_in_as', as: 'sign_in_as'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root to: "home#show"
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
