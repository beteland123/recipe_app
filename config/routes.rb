Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'

  resources :users, only: [] do
    resources :recipes, only: [:index]
  end

  resources :recipes, except: [:update] do
    member do
      patch 'toggle_public'
      get 'public_recipes'
    end
  end
end
