# frozen_string_literal: true

# migration CreateCompanies
class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.decimal :balance, precision: 9, scale: 2, default: 0

      t.timestamps
    end
  end
end
