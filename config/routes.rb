Rails.application.routes.draw do
  
 
  resources :genres
  root "movies#index"
  resources:movies do
    resources:reviews
    resources:favorites, only:[:destroy, :create]
  end
  resources :users
  get "signup" => "users#new"

  resource :session, only:[:destroy, :create, :new]
  get "signin" => "sessions#new"
end
