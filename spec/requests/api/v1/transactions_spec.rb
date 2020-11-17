# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/transactions', type: :request do
  describe 'GET /index' do
    let!(:transactions) { create_list(:transaction, 5) }

    context 'without filter params' do
      before { get '/api/v1/transactions', as: :json }

      let(:data) { JSON.parse(body) }

      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(200) }
      it { expect(response).to have_http_status(:ok) }
      it { expect(data['transactions'].length).to eq(5) }
    end

    context 'with #company_id filter params' do
      let(:company) { transactions.first.company }
      let(:transaction_count) { company.transactions.size }
      let(:filter) { { filter: { company_id: company.id } } }

      before { get '/api/v1/transactions', params: filter }

      let(:data) { JSON.parse(body) }

      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(200) }
      it { expect(response).to have_http_status(:ok) }
      it 'is expected to match transactions total records' do
        expect(data['transactions'].length).to eq(company.transactions.size)
      end
      it 'is expected to match company balance' do
        expect(data['company']['balance']).to eq(company.balance.to_s)
      end
    end
  end

  describe 'POST /upload' do
    context 'with valid parameters' do
      let(:file_valid) { { file: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/cnab_valid.txt'))) } }

      before(:each) { load "#{Rails.root}/db/seeds.rb" }

      before { post '/api/v1/transactions/upload', params: { transaction: file_valid } }

      let(:data) { JSON.parse(body) }

      it { expect(response).to have_http_status(201) }
      it { expect(response).to have_http_status(:created) }
      it { expect(data['message']).to eq('CNAB file uploaded.') }
    end

    context 'with invalid parameters' do
      let(:file_valid) { { file: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/cnab_invalid.txt'))) } }

      before(:each) { load "#{Rails.root}/db/seeds.rb" }

      before { post '/api/v1/transactions/upload', params: { transaction: file_valid } }

      let(:data) { JSON.parse(body) }

      it { expect(response).to have_http_status(422) }
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(data['message']).to eq('Error CNAB file.') }
    end
  end
end
