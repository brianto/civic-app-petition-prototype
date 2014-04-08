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
  resources :constants
  
  # Constants
  #get "/constants/edit" => "constants#edit"
  #post "/constants/:id" => "constants#update"
  post "/contants/:id/update", :to => "constants#update"#, :as => :constants
  
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
  
  # Report a petition
  get "/petitions/:id/report" => "petitions#report"
  
  # Generate live previews
  post "/preview" => "petitions#preview"
  
  
  # Paginate Petitions
  get "/petitions/page/:page" => "petitions#index"

  # Paginate signatures
  get "/petitions/:id/:page" => "petitions#show"
  
  # Paginate political responses
  get "/politicians/:id/:page" => "politicians#show"
  
end
