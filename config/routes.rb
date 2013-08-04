TalebinCom::Application.routes.draw do
  
  get 'about' => 'general#about'
 
  devise_for :users, :path => '/', :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :sign_up => 'signup' } , :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :sessions => "users/sessions", :registrations => "users/registrations" } do
    match '/auth/yahoo/callback', :controller => 'users/omniauth_callbacks', :action => 'yahoo'
    match '/edit_secret_profile' => 'devise/registrations#edit'
    match 'user_confirmation_url' => 'devise/confirmation#new'
    match '/users/point/:id/:value' => 'users#point', :as => :point
    match '/users/respond/:id/:value' => 'users#respond', :as => :respond
    match '/users/invite/:id' => 'users#invite', :as => :invite
    get   '/users/list' => 'users#list'
    get   '/actas/:id' => 'users#actas'
    post  '/users/update' => 'users#update', :as => :update_user
    match '/users/:id/avatar' => 'users#avatar', :as => :avatar
  end
  
  get '/weekly/:uid' => "horoscopes#show", :as => :weekly
  get '/user/:hid' => 'users#show', :as => :user
  post '/users/suggest' => 'users#suggest', :as => :suggest
  get '/home' => 'users#home', :as => :home
  match '/profile' => 'users#profile', :as => :profile
  
  get '/:page/blog/:id/:name(.:format)' => 'general#static'
  resources :cards do
    collection do
      get 'my/:cards', :action => :show, :as => :my
    end
  end
  resources :tarots do
    collection do
      get 'my/:cards', :action => :show, :as => :my
    end
  end
  resources :horoscopes
  resources :celebrities
  resources :messages do
    collection do
      get :list  #'/messages/list' => 'users#list'
    end
  end

  root :to => 'general#index'

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
