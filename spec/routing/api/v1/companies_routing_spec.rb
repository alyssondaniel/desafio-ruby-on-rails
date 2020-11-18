# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::CompaniesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/companies').to route_to('api/v1/companies#index')
    end
  end
end
