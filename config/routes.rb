Rails.application.routes.draw do
  resources :recipe_foods, only: [ :new, :create, :edit, :update, :destroy ]
  resources :foods, only: [ :index, :new, :create, :destroy ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
