class CreateTransactionTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_types do |t|
      t.integer :code, null: false
      t.string :description, null: false
      t.string :way, null: false
      t.string :signal_char, null: false

      t.timestamps
    end
    add_index :transaction_types, :code, unique: true
  end
end
