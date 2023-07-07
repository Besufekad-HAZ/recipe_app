class GeneralShoppingListsController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes
    @general_food_list = @user.foods

    @missing_foods = calculate_missing_foods
    @total_count = calculate_total_count
    @total_price = calculate_total_price
  end

  private

  def calculate_missing_foods
    general_food_quantities = @general_food_list.group(:name).sum(:quantity)

    recipe_food_quantities = @recipes.flat_map do |recipe|
      recipe.recipe_foods.map { |rf| { name: rf.food.name, quantity: rf.quantity } }
    end

    missing_foods = recipe_food_quantities.select do |food_hash|
      name = food_hash[:name]
      quantity = food_hash[:quantity]
      general_food_quantities[name].to_i < quantity
    end

    missing_foods.map do |food_hash|
      {
        name: food_hash[:name],
        quantity: food_hash[:quantity] - general_food_quantities[food_hash[:name]].to_i
      }
    end
  end

  def calculate_total_count
    @missing_foods.sum { |missing_food| missing_food[:quantity] }
  end

  def calculate_total_price
    total_price = 0
    @missing_foods.each do |missing_food|
      name = missing_food[:name]
      quantity = missing_food[:quantity]
      food = @general_food_list.find_by(name:)
      total_price += food&.price.to_f * quantity if food
    end
    total_price
  end
end
