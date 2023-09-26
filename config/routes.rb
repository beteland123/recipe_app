Rails.application.routes.draw do
resources :users
resources :recipes do
    member do
      post 'toggle_public'
    end
  end
  get 'public_recipes', to: 'recipes#public_index', as: :public_recipes
end
