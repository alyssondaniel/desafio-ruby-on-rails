require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }

    context 'Uniqueness' do
      subject { Company.new(name: 'something') }
      it { should validate_uniqueness_of(:name) }
    end
  end
end
