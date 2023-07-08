require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { User.create(name: 'John', email: 'john@example.com', password: 'password') }

  describe 'validations' do
    it 'should validate presence of name' do
      food = Food.new(measurement_unit: 'gram', price: 1, quantity: 3, user:)
      expect(food).not_to be_valid
      expect(food.errors[:name]).to include("can't be blank")
    end

    it 'should validate presence of measurement_unit' do
      food = Food.new(name: 'Salt', price: 1, quantity: 3, user:)
      expect(food).not_to be_valid
      expect(food.errors[:measurement_unit]).to include("can't be blank")
    end

    it 'should validate presence of price' do
      food = Food.new(name: 'Salt', measurement_unit: 'gram', quantity: 3, user:)
      expect(food).not_to be_valid
      expect(food.errors[:price]).to include("can't be blank")
    end

    it 'should validate presence of quantity' do
      food = Food.new(name: 'Salt', measurement_unit: 'gram', price: 1, user:)
      expect(food).not_to be_valid
      expect(food.errors[:quantity]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'should belong to a user' do
      food = Food.new(name: 'Salt', measurement_unit: 'gram', price: 1, quantity: 3)
      food.user = user
      expect(food.user).to eq(user)
    end

    it 'should have many recipe_foods' do
      food = Food.new(name: 'Salt', measurement_unit: 'gram', price: 1, quantity: 3)
      recipe_food = RecipeFood.new(quantity: 2)
      food.recipe_foods << recipe_food
      expect(food.recipe_foods).to include(recipe_food)
    end

    it 'should have many recipes through recipe_foods' do
      food = Food.new(name: 'Salt', measurement_unit: 'gram', price: 1, quantity: 3)
      recipe1 = Recipe.new(name: 'Chicken Biryani', description: 'How to cook chicken biryani', user:)
      recipe2 = Recipe.new(name: 'Pasta', description: 'How to cook pasta', user:)
      recipe_food1 = RecipeFood.new(recipe: recipe1, quantity: 2)
      recipe_food2 = RecipeFood.new(recipe: recipe2, quantity: 3)
      food.recipe_foods << [recipe_food1, recipe_food2]
      expect(food.recipes).to include(recipe1, recipe2)
    end
  end
end
