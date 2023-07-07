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
    recipe_food_quantities = @recipes.flat_map { |recipe| recipe.foods.group(:name).sum(:quantity) }
    p "PLEASE recipes #{@recipes.each {|recipe| recipe.foods}} "
    p "recipe_food_quantities #{recipe_food_quantities}"

    missing_foods = []
    missing_food = {}
    recipe_food_quantities.each do |food_hash|
      food_hash.each do |name, quantity|
        if general_food_quantities[name].to_i < quantity
          missing_food[name] = quantity - general_food_quantities[name].to_i
        end
        missing_foods << missing_food
      end
    end

    p "HERE PLEASE missing_foods #{missing_foods}"
    missing_foods
  end

  def calculate_total_count
    @missing_foods.sum(:quantity)
  end

  def calculate_total_price
    @missing_foods.sum(:price)
  end
end
