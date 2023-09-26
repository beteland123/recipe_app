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

  root 'recipes#public_recipes_list'
end
