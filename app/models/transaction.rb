class Transaction < ApplicationRecord
  belongs_to :transaction_type
  belongs_to :company

  validates :transaction_type_id, :company_id, :occurrence_at, :amount,
            :document, :card_number, :owner_name, presence: true

  scope :amount_in, -> { joins(:transaction_type).where(transaction_types: { way: 'Entrada' }).sum(:amount) }
  scope :amount_out, -> { joins(:transaction_type).where(transaction_types: { way: 'Saída' }).sum(:amount) }
end
