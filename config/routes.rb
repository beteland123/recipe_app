Rails.application.routes.draw do
resources :users
resources :recipes do
    patch 'toggle_public', on: :member
  end
end
