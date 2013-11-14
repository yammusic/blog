Blog::Application.routes.draw do

  match '/auth/:provider/callback' => 'authentications#callback'
  delete 'authentications/destroy_provider', :to => 'authentications#destroy_provider', :as => 'destroy_provider'

  devise_for :users, :controllers => { :password => :users }

  resources :users do
    collection do
      put 'update_password'
    end

    resources :profiles do
      collection do
        get ':action'
        put 'update_avatar'
        put 'update_profile'
        get 'profile', :to => 'profiles#profile', :as => 'profile'
        get 'avatar', :to => 'profiles#avatar', :as => 'avatar'
        get 'social', :to => 'profiles#social', :as => 'social'
        get 'account', :to => 'profiles#account', :as => 'account'
      end
    end
  end

    namespace :mercury do
      resources :images
    end

  mount Mercury::Engine => '/'
  get '/editor(*requested_uri)(.:format)', :to => 'mercury#edit', :as => 'mercury_editor'

  resources :posts do
    resources :comments, :tags
    member { post :mercury_update }
  end

  resources :categories

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
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'posts#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
