CivicAppPetitionPrototype::Application.routes.draw do
  root 'petitions#index'
  
  resources :petitions
  resources :residents
  resources :politicians
  resources :users
  
  # Constants
  get "/constants/edit" => "constants#edit"
  post "/constants" => "constants#update"
  
  # Login
  get "/login" => "user_session#new"
  post "/login" => "user_session#create"
  get "/logout" => "user_session#destroy"
  
  # AdminController
  get "/admin" => "admin#index"
  
  post "/petitions/:id/sign" => "petitions#sign"
  
  get "/search" => "petitions#search"
  get "/petitions/search" => "petitions#search"
  
  get "/petitions/find/:query" => "petitions#find"
end
