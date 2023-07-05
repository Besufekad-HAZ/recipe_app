class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @recipes = @user.recipes
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params.except(:food_quantities))
    @recipe.user = current_user

    if @recipe.save
      create_recipe_foods(@recipe, recipe_params[:food_quantities])
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.recipe_foods.destroy_all
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully destroyed.'
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, food_quantities: {})
  end

  def create_recipe_foods(recipe, food_quantities)
    return unless food_quantities.is_a?(Hash)

    food_quantities.each do |food_id, quantity|
      next if quantity.to_i < 1

      recipe.recipe_foods.create(food_id: food_id, quantity: quantity.to_i)
    end
  end
end
