class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :transaction_type, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.datetime :occurrence_at, null: false
      t.decimal :amount, precision: 9, scale: 2, default: 0
      t.string :document, null: false
      t.string :card_number, null: false
      t.string :owner_name, null: false

      t.timestamps
    end
  end
end
