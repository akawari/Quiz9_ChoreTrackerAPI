Rails.application.routes.draw do
  scope module: 'api' do     
    namespace :v1 do
      resources :children
      resources :tasks
      resources :chores
      resources :users
      resources :application
      
      get '/token' => 'application#token', as: :token
    end
    
    namespace :v2 do
      resources :children
      resources :tasks
      resources :chores
      resources :users
      resources :application
      
      get '/token' => 'application#token', as: :token
      
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
