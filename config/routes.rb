CivicAppPetitionPrototype::Application.routes.draw do
  root 'petitions#index'
  
  resources :petitions
  resources :residents
  resources :users
  
  get "/login" => "user_session#new"
  post "/login" => "user_session#create"
  get "/logout" => "user_session#destroy"
end
