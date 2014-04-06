CivicAppPetitionPrototype::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'petitions#index'
  
  resources :petitions do
    resources :responses, :shallow => true
  end
  
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
  
  # Paginate
  get "/petitions/page/:page" => "petitions#index"
  
  get "/petitions/:id/:page" => "petitions#show"
end
