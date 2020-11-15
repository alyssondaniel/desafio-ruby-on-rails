# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    balance { Faker::Number.decimal(l_digits: 2) }
  end
end
