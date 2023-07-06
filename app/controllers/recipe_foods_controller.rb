class RecipeFoodsController < ApplicationController
  before_action :set_recipe_food, only: %i[show edit update destroy]

  def index
    @recipe_foods = RecipeFood.all
  end

  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      redirect_to recipe_food_url(@recipe_food), notice: 'Recipe food was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @recipe_food.update(recipe_food_params)
      redirect_to recipe_food_url(@recipe_food), notice: 'Recipe food was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe_food.destroy
    redirect_to recipe_foods_url, notice: 'Recipe food was successfully destroyed.'
  end

  private

  def set_recipe_food
    @recipe_food = RecipeFood.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id)
  end
end
