ShowCrawl::Application.routes.draw do

  resources :eps,:only => [:show, :index, :edit, :destroy] do 
    collection do
      put 'search'
      put 'update_ep'
    end
  end

  resources :sources,:only => [:new, :edit,:update,:create,:destroy]

  resources :ep_v2s,:only => [:show, :index, :edit, :destroy] do 
    collection do
      put 'search'
      put 'update_ep'
    end
  end

  resources :source_v2s,:only => [:new, :edit,:update,:create,:destroy]  
  
  namespace :api do
    get 'promotion' => 'api#promotion'
    get 'version_check' => 'api#version_check'
    namespace :v1 do
      resources :shows do
        collection do
          get 'shows_info'
          put 'update_device_watch'
        end  
      end

      resources :eps    
    end
    namespace :v2 do
      resources :appprojects, :only => [:index]
      resources :shows do
        collection do
          get 'shows_info'
          put 'update_device_watch'
        end  
      end

      resources :eps
      
      resources :devices,:only => [:create]    
    end
  end
end

