InitialRelease::Application.routes.draw do  
  
  mount Ckeditor::Engine => '/ckeditor'
  
  resources :password_resets
  resources :sessions

  get 'wellcom' => 'home#wellcom'
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  
  #constraints(Subdomain) do
  #  match '/' => 'cities#this'
  #end
  match '', to: 'cities#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  
  #match "/cities/:id", :to => "cities#show"
  root :to =>  "cities#index", :requirements => { :subdomain => "voronezh" } #"cities#index"

  defaults :subdomain => false do
    root :to => 'cities#index'
  end

  #match 'with_area/:area_id' => "cities#show"
  #match 'cities/:id/with_chain/:chain_id' => "cities#show"
  #match 'cities/:id/with_area/:area_id/with_chain/:chain_id' => "cities#show"

  resources :prices
  resources :promotions do
    post :search, on: :collection
    #post :search, on: :collection
    get :start    
  end

  resources :photo_prices
  resources :chains
  resources :products
  resources :discussions do
    member do
      get 'change_visible'
    end
  end

  resources :cities do
    get :set_shops_prices
    get :update_shop_raiting
    resources :shops
    resources :xml_files
    resource :shop_products
    resources :areas do
      resources :chains do 
        resources :shops
      end
    end
  end

  resources :areas do
    resources :shops
  end

  resources :users do
    resources :roles
    resources :xml_files
    member do
      get :activate
    end
  end

  
  #root to: "home#wellcom"

  #get "/:city" => "home#wellcom"


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
