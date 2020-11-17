# frozen_string_literal: true

module Api
  module V1
    # TransactionsController
    class TransactionsController < ApplicationController
      before_action :authorize_request
      before_action :prepare_bulk, only: :upload

      # GET /api/v1/transactions
      def index
        @transactions = Transaction.all

        if params[:filter]
          filter = params[:filter]
          if filter[:company_id].present?
            @company = Company.find_by_id(filter[:company_id])
            @transactions = @transactions.where(company_id: filter[:company_id])
          end
        end

        render json: { transactions: @transactions, company: @company }
      end

      # POST /api/v1/transactions/upload
      def upload
        Transaction.insert_all!(@bulk_transactions)
        @companies.map(&:calc_balance!)
        render json: { message: 'CNAB file uploaded.' }, status: :created
      rescue StandardError => e
        Rails.logger.info "Error CNAB file: #{e.message}"
        render json: { message: 'Error CNAB file.' }, status: :unprocessable_entity
      end

      private

      def transaction_params
        params.require(:transaction).permit(:file)
      end

      def prepare_bulk
        @bulk_transactions = []
        @companies = []
        File.read(transaction_params[:file].tempfile).split("\n").each do |line|
          code = line[0, 1]
          date = line[1, 8]
          amount = (line[9, 10].to_f / 100.00).round(2)
          document = line[19, 11]
          card_number = line[30, 12]
          hour = line[42, 6]
          owner_name = line[48, 14]
          company_name = line[62, 19]
          company = Company.find_or_initialize_by name: company_name.strip
          company.save! if company.new_record?
          @companies << company
          transaction_type = TransactionType.find_by code: code
          next unless transaction_type && company

          occurrence_at = "#{date[0, 4]}-#{date[4, 2]}-#{date[6, 2]} #{hour[0, 2]}:#{hour[2, 2]}:#{hour[4, 2]}"
          time_now = Time.now
          @bulk_transactions << {
            company_id: company.id,
            transaction_type_id: transaction_type.id,
            occurrence_at: occurrence_at,
            amount: amount,
            document: document,
            card_number: card_number,
            owner_name: owner_name.strip,
            created_at: time_now,
            updated_at: time_now
          }
        end
      end
    end
  end
end
