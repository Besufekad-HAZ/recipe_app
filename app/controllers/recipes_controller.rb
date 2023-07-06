class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @recipes = @user.recipes.includes(:foods)
  end


  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params.except(:food_quantities))
    @recipe.user = current_user
    if @recipe.save
      food_quantities = recipe_params[:food_quantities]
      food_quantities&.each do |food_id, quantity|
        @recipe.recipe_foods.create(food_id: food_id, quantity: quantity.to_i, recipe_id: @recipe.id) unless quantity.to_i < 1
      end
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.includes(:foods).find_by(id: params[:id])
    @recipe.public = @recipe.public?
  end

  def toggle
    @recipe = Recipe.find(params[:id])
    if current_user == @recipe.user
      @recipe.update(public: !@recipe.public?)
      flash.notice = "Recipe privacy has been updated."
      # Add the following line to set the public attribute to true
      @recipe.update(public: true) if @recipe.public?
    end
    redirect_to recipe_path(@recipe)
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
