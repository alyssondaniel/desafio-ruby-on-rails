# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Associations' do
    it { should belong_to(:company).class_name('Company') }
    it { should belong_to(:transaction_type).class_name('TransactionType') }
  end

  describe 'Validations' do
    it { should validate_presence_of(:transaction_type_id) }
    it { should validate_presence_of(:company_id) }
    it { should validate_presence_of(:occurrence_at) }
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:document) }
    it { should validate_presence_of(:card_number) }
    it { should validate_presence_of(:owner_name) }
  end
end
