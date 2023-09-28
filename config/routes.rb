Rails.application.routes.draw do
  get 'recipe_steps/new'
  get 'recipe_steps/create'
  devise_for :users
  root to: 'recipes#index'

  resources :users, only: [] do
    resources :recipes, only: [:index]
  end

  resources :recipes, except: [:update] do
    member do
      patch 'toggle_public'
      get 'public_recipes' # Change from patch to get
      patch 'update_times'
      get 'new_step', to: 'recipe_steps#new'
      post 'create_step', to: 'recipe_steps#create'
      get 'shopping_list', to: 'recipes#shopping_list'
      get 'add_ingredient', to: 'recipes#add_ingredient'
    end
  end
end
