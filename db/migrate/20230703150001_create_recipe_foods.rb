# frozen_string_literal: true

# This migration creates the `recipe_foods` table.
# It defines the columns `quantity`, `recipe_id`, and `food_id`.
# It also adds foreign key constraints and indexes to establish relationships.

class CreateRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_foods do |t|
      t.integer :quantity
      t.integer :recipe_id
      t.integer :food_id

      t.timestamps
    end
    add_foreign_key :recipe_foods, :recipes, column: :recipe_id
    add_foreign_key :recipe_foods, :foods, column: :food_id
    add_index :recipe_foods, :recipe_id
    add_index :recipe_foods, :food_id
  end
end
