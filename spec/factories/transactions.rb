# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    occurrence_at { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
    amount { Faker::Number.decimal(l_digits: 2) }
    document { Faker::IDNumber.brazilian_citizen_number }
    card_number { Faker::Finance.credit_card }
    owner_name { Faker::FunnyName.name }

    association :transaction_type
    association :company
  end
end
