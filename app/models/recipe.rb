# frozen_string_literal: true

# The Recipe class represents a recipe in the application.
class Recipe < ApplicationRecord
  belongs_to :user
end
