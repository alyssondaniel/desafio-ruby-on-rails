# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/transactions').to route_to('api/v1/transactions#index')
    end

    it 'routes to #upload' do
      expect(post: '/api/v1/transactions/upload').to route_to('api/v1/transactions#upload')
    end
  end
end
