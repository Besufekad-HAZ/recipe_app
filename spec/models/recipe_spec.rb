require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:food1) { Food.create(name: 'Ingredient 1', price: 2.5) }
  let(:food2) { Food.create(name: 'Ingredient 2', price: 3.0) }
  let(:recipe) do
    Recipe.new(name: 'Test Recipe', preparation_time: 10, cooking_time: 20, description: 'A delicious recipe', user:)
  end

  describe 'validations' do
    it 'validates presence of name' do
      recipe.name = nil
      expect(recipe).not_to be_valid
      expect(recipe.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of preparation_time' do
      recipe.preparation_time = nil
      expect(recipe).not_to be_valid
      expect(recipe.errors[:preparation_time]).to include("can't be blank")
    end

    it 'validates presence of cooking_time' do
      recipe.cooking_time = nil
      expect(recipe).not_to be_valid
      expect(recipe.errors[:cooking_time]).to include("can't be blank")
    end

    it 'validates presence of description' do
      recipe.description = nil
      expect(recipe).not_to be_valid
      expect(recipe.errors[:description]).to include("can't be blank")
    end
  end
end
