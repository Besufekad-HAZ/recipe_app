# frozen_string_literal: true

Rails.application.routes.draw do
  resources :shopping_lists
  devise_for :users

  resources :users, only: [:show]
  resources :recipes, except: [:update] do
    patch 'toggle', on: :member
  end
  resources :foods, except: [:update]
  resources :recipes do
    resources :recipe_foods, only: [:new, :create, :edit, :update, :show, :destroy]
  end
  resources :shopping_lists, only: [:index]

  resources :general_shopping_lists, only: [:index]

  get 'general_shopping_list_index', to: 'general_shopping_list#index'
  get '/public_recipes', to: 'public_recipes#index'
  #get 'recipes/:recipe_id/recipe_foods/new', to: 'recipe_foods#new', as: 'new_recipe_recipe_food'

  root to: 'public_recipes#index'
end
