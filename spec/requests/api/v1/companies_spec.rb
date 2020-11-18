# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/companies', type: :request do
  let(:headers) { { 'Authorization': "Bearer #{Rails.application.credentials.auth0[:token]}" } }

  describe 'GET /index' do
    let!(:companies) { create_list(:company, 5) }

    context 'without filter params' do
      before { get '/api/v1/companies', as: :json, headers: headers }

      let(:data) { JSON.parse(body) }

      it { expect(response).to be_successful }
      it { expect(response).to have_http_status(200) }
      it { expect(response).to have_http_status(:ok) }
      it { expect(data.length).to eq(5) }
    end
  end
end
