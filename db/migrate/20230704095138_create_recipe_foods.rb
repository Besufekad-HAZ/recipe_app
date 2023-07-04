# frozen_string_literal: true

class CreateRecipeFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_foods do |t|
      t.integer :quantity
      t.references :food, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps null: false, default: -> { 'CURRENT_TIMESTAMP' }
    end

    remove_index :recipe_foods, :recipe_id if index_exists?(:recipe_foods, :recipe_id)
    remove_index :recipe_foods, :food_id if index_exists?(:recipe_foods, :food_id)

    add_index :recipe_foods, :recipe_id unless index_exists?(:recipe_foods, :recipe_id)
    add_index :recipe_foods, :food_id unless index_exists?(:recipe_foods, :food_id)
  end
end
