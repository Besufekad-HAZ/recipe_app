require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before(:each) do
    @user = User.find_or_create_by!(email: 'john@example.com') do |user|
      user.name = 'John'
      user.password = 'password'
    end

    @food = Food.create!(name: 'Salt', measurement_unit: 'gram', price: 2, quantity: 10, user_id: @user.id)
    @recipe = Recipe.create!(name: 'Recipe 1', instructions: 'Some instructions', user_id: @user.id)
    @recipe_food = RecipeFood.create!(quantity: 10, food: @food, recipe: @recipe)
  end


  it 'test value method' do
    expect(@recipe_food.food.price).to eql 2
    expect(@recipe_food.value).to eql 20
  end

  it 'test total_price method' do
    expect(@recipe_food.food.price).to eql 2
    expect(@recipe_food.total_price).to eql 20
  end

  it 'test shopping list method' do
    shop_list = RecipeFood.generate_shopping_list(@user)
    expect(shop_list).to be_an_instance_of(Array)
    expect(shop_list.length).to eql 1
    expect(shop_list[0][:name]).to eql 'Salt'
    expect(shop_list[0][:quantity]).to eql 10
    expect(shop_list[0][:measurement_unit]).to eql 'gram'
  end
end
