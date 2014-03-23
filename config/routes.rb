CivicAppPetitionPrototype::Application.routes.draw do
  root 'petitions#index'
  
  resources :petitions
  resources :residents
  resources :users
  
  get "/login" => "user_session#new"
  post "/login" => "user_session#create"
  get "/logout" => "user_session#destroy"
  
  post "/petitions/:id/sign" => "petitions#sign"
  
  get "/search" => "petitions#search"
  get "/petitions/search" => "petitions#search"
  
  post "/petitions/find" => "petitions#find"
end
