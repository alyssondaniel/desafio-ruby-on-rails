# frozen_string_literal: true

module Api
  module V1
    # CompaniesController
    class CompaniesController < ApplicationController
      before_action :authorize_request

      # GET /api/v1/companies
      def index
        @companies = Company.all

        render json: @companies
      end
    end
  end
end
