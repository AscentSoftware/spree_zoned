Spree::Core::Engine.add_routes do
  post '/activezone/set', :to => 'active_zone#set', :defaults => { :format => :json }, :as => :set_active_zone

  namespace :admin do
    resources :products do
      resources :prices, :only => [:index, :create]
    end
  end
end
