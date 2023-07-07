require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:all) do
    @user = User.create(name: 'John', email: 'john@example.com', password: 'password')
  end

  it 'should have a user' do
    @food = Food.create(name: 'Salt', measurement_unit: 'gram', price: 1, quantity: 3, user: @user)
    expect(@food.user).to eq(@user)
  end

  it 'should have a name' do
    @food = Food.new(measurement_unit: 'gram', price: 1, quantity: 3, user: @user)
    expect(@food).not_to be_valid
    expect(@food.errors[:name]).to include("can't be blank")
  end

  it 'should have a measurement_unit' do
    @food = Food.new(name: 'Salt', price: 1, quantity: 3, user: @user)
    expect(@food).not_to be_valid
    expect(@food.errors[:measurement_unit]).to include("can't be blank")
  end

  it 'should have a price' do
    @food = Food.new(name: 'Salt', measurement_unit: 'gram', quantity: 3, user: @user)
    expect(@food).not_to be_valid
    expect(@food.errors[:price]).to include("can't be blank")
  end

  it 'should have a quantity' do
    @food = Food.new(name: 'Salt', measurement_unit: 'gram', price: 1, user: @user)
    expect(@food).not_to be_valid
    expect(@food.errors[:quantity]).to include("can't be blank")
  end
end
