Rails.application.routes.draw do
  devise_for :users
  
  resources :users, only: [] do
    get 'recipes_list', on: :collection
    delete 'delete_recipe/:id', to: 'users#delete_recipe', on: :member, as: :delete_recipe
  end

  resources :recipes, only: [] do
    get 'public_recipes_list', on: :collection
    get 'recipe_details/:id', to: 'recipes#recipe_details', on: :member, as: :recipe_details
    post 'toggle_public/:id', to: 'recipes#toggle_public', on: :member, as: :toggle_public
  end

  root 'recipes#recipes_details'

  devise_scope :user do
    get "/custom_sign_out" => "devise/sessions#destroy", as: :custom_destroy_user_session
  end
#  root "foods#index"
  resources :recipe_foods, only: [ :new, :create, :edit, :update, :destroy ]
  resources :foods, only: [ :index, :new, :create, :destroy ]
  resources :users
  resources :recipes
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
