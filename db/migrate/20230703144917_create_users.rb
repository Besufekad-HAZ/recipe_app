# frozen_string_literal: true

# This migration creates the `users` table.
# It defines the column `name` and timestamps for created and updated.

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end
  end
end
