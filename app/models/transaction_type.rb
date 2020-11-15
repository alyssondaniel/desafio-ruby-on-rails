class TransactionType < ApplicationRecord
  enum way: { in: 'Entrada', out: 'Saída' }

  has_many :transactions

  validates :code, :description, :way, :signal_char, presence: true
  validates :code, uniqueness: true
end
