class TransactionType < ApplicationRecord
  enum way: { in: 'Entrada', out: 'Saída' }

  validates :code, :description, :way, :signal_char, presence: true
  validates :code, uniqueness: true
end
