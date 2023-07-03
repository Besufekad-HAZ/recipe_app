# frozen_string_literal: true

# The RecipeFood class represents the association between a recipe and a food item in the application.
class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
end
