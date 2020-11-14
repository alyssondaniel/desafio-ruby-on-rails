# frozen_string_literal: true

FactoryBot.define do
  factory :transaction_type do
    code { Faker::Number.number(digits: 4) }
    description { Faker::Lorem.sentence }
    way { %i[in out].sample }
    signal_char { ['+', '-'].sample }
  end
end
