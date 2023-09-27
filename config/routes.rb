Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/custom_sign_out" => "devise/sessions#destroy", as: :custom_destroy_user_session
  end
  root "foods#index"
  resources :recipe_foods, only: [ :new, :create, :edit, :update, :destroy ]
  resources :foods, only: [ :index, :new, :create, :destroy ]
  resources :users
  resources :recipes
  get '/general_shopping_list', to: 'foods#general_shopping_list', as: 'general_shopping_list'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
