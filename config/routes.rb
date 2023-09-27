Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index' # Set the recipe list as the homepage

  resources :users, only: [] do
    resources :recipes, only: [:index] # User's recipe list
  end

  resources :recipes, except: [:update] do
    member do
      patch 'toggle_public' # Route for toggling recipe public/private
      get 'public_recipes' # Route for displaying public recipes
    end
  end
end
