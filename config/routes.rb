Rails.application.routes.draw do
  devise_for :users , :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :topics do 
  	resources :comments, :controller => :comments, only: [:new, :create, :edit, :update, :destroy]
    resources :subscribes, :controller => :subscribes, only: [:create, :destroy]  
    # /topics/:topic_id/subscribes
    
      member do 
        post :like
        post :unlike

      end  
  end
  get '/profile/:nickname' => 'profiles#show'  , as: :profile
  resources :users do 	
  	resource :profile , :controller => :profiles, :except => [:show]  do  
      collection do 
        get :likes
        get :subscribes

      end
    end
  end


  resource :profile , :controller => :profiles 
  
  get 'tags/:tag', to: 'topics#index', as: "tag"
  get '/about' => 'topics#about', :as => "about"
  root :to => 'topics#index'
end
  