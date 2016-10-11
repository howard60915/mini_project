Rails.application.routes.draw do
  devise_for :users 
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :topics do 
  	resources :comments, :controller => :comments
  end
  resources :users do 	
  	resource :profile , :controller => :profiles
  end

  resource :profile , :controller => :profiles
     
  get '/about' => 'topics#about', :as => "about"
  root :to => 'topics#index'
end
