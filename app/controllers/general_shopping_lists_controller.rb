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
    p "general_food_quantities #{general_food_quantities}"
    recipe_food_quantities = @recipes.flat_map { |recipe| recipe.recipe_foods.map { |rf| { name: rf.food.name, quantity: rf.quantity } } }
    p "recipe_food_quantities #{recipe_food_quantities}"

    missing_foods = []

    recipe_food_quantities.each do |food_hash|
      name = food_hash[:name]
      quantity = food_hash[:quantity]
      if general_food_quantities[name].to_i < quantity
        missing_food = {
          name: name,
          quantity: quantity - general_food_quantities[name].to_i
        }
        missing_foods << missing_food
      end
    end

    p "HERE PLEASE missing_foods #{missing_foods}"
    missing_foods
  end

  def calculate_total_count
    @missing_foods.sum { |missing_food| missing_food[:quantity] }
  end

  def calculate_total_price
    total_price = 0
    @missing_foods.each do |missing_food|
      name = missing_food[:name]
      quantity = missing_food[:quantity]
      food = @general_food_list.find_by(name: name)
      total_price += food&.price.to_f * quantity if food
    end
    total_price
  end
end
