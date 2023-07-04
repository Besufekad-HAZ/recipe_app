Rails.application.routes.draw do
  resources :foods
  resources :recipe_foods
  resources :recipes
  devise_for :users
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
