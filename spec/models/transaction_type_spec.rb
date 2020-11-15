require 'rails_helper'

RSpec.describe TransactionType, type: :model do
  it do
    should define_enum_for(:way)
      .with_values(in: 'Entrada', out: 'Saída')
      .backed_by_column_of_type(:string)
  end

  describe 'Associations' do
    it { should have_many(:transactions).class_name('Transaction') }
  end

  describe 'Validations' do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:way) }
    it { should validate_presence_of(:signal_char) }
    context 'Uniqueness' do
      subject { TransactionType.new(code: 1, description: '', way: :in, signal_char: '+') }
      it { should validate_uniqueness_of(:code) }
    end
  end
end
