Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [ :show, :update]
      resources :trips
      resources :posts
      resources :friendships
      post '/signup', to: 'users#create'
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      get '/current_user', to: 'auth#show'
      get '/other_users', to: 'users#users_list'
      mount ActionCable.server => '/cable'
    end
  end
end
