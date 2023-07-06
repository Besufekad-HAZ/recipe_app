# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show]
  # resources :recipes, except: [:update] do
  #   patch 'toggle', on: :member
  # end
  resources :foods, except: [:update]
  resources :recipes do
    resources :recipes do
  resources :recipe_foods, only: [:new, :create]
end

  resources :recipe_foods, only: [:new, :create]
 end

  get 'general_shopping_list_index', to: 'general_shopping_list#index'
  get '/public_recipes', to: 'public_recipes#index'
  #get 'recipes/:recipe_id/recipe_foods/new', to: 'recipe_foods#new', as: 'new_recipe_recipe_food'

  root to: 'public_recipes#index'
end

