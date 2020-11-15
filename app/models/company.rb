class Company < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name

  has_many :transactions

  def calc_balance!
    update balance: transactions.amount_in - transactions.amount_out
  end
end
