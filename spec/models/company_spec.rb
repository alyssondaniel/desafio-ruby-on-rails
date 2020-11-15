# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }

    context 'Uniqueness' do
      subject { Company.new(name: 'something') }
      it { should validate_uniqueness_of(:name) }
    end
  end

  describe 'Associations' do
    it { should have_many(:transactions).class_name('Transaction') }
  end

  describe 'Calc Balance' do
    let!(:company) { create(:company, balance: 11.22) }
    let!(:transactions) { create_list(:transaction, 15, company: company) }
    it do
      balance = 0
      transactions.each do |transaction|
        if transaction.transaction_type.in?
          balance += transaction.amount
        elsif transaction.transaction_type.out?
          balance -= transaction.amount
        end
      end
      company.calc_balance!
      expect(company.balance.to_f).to eq(balance.to_f)
    end
  end
end
