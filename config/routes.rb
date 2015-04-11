Rails.application.routes.draw do

  devise_for :users

  namespace :admin do
    resources :users
    resources :species, param: :url
    resources :specimens
    resources :references
    resources :locations
    resources :characteristics, param: :uuid
    resources :languages
  end

  root to: 'users#index'
end
