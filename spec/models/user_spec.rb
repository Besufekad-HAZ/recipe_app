require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'should have a valid name' do
      user = User.new(email: 'john@example.com', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'should have a valid email' do
      user = User.new(name: 'John', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'should have a unique email' do
      User.create(name: 'John', email: 'john@example.com', password: 'password')
      user = User.new(name: 'John', email: 'john@example.com', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end

    it 'should have a valid password' do
      user = User.new(name: 'John', email: 'john@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'should have a password with minimum length' do
      user = User.new(name: 'John', email: 'john@example.com', password: 'pass')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end

  describe 'associations' do
    it 'should have many recipes' do
      user = User.new(name: 'John', email: 'john@example.com', password: 'password')
      expect(user).to respond_to(:recipes)
    end

    it 'should have many foods' do
      user = User.new(name: 'John', email: 'john@example.com', password: 'password')
      expect(user).to respond_to(:foods)
    end
  end
end
