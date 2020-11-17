# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
[
  { code: 1, description: 'Débito', way: :in,	signal_char: '+' },
  { code: 2, description: 'Boleto', way: :out,	signal_char: '-' },
  { code: 3, description: 'Financiamento', way: :out,	signal_char: '-' },
  { code: 4, description: 'Crédito', way: :in,	signal_char: '+' },
  { code: 5, description: 'Recebimento Empréstimo', way: :in,	signal_char: '+' },
  { code: 6, description: 'Vendas', way: :in,	signal_char: '+' },
  { code: 7, description: 'Recebimento TED', way: :in,	signal_char: '+' },
  { code: 8, description: 'Recebimento DOC', way: :in,	signal_char: '+' },
  { code: 9, description: 'Aluguel', way: :out,	signal_char: '-' }
].each do |type|
  transaction_type = TransactionType.find_or_initialize_by code: type[:code]
  if transaction_type.new_record?
    transaction_type.description = type[:description]
    transaction_type.way = type[:way]
    transaction_type.signal_char = type[:signal_char]
    if transaction_type.save
      puts "Transaction type #{transaction_type.description} created!" if Rails.env.development?
    else
      puts "Error - Code: #{type[:code]}. #{transaction_type.errors.full_messages.join(', ')}"
    end
  elsif Rails.env.development?
    puts "Transaction type ##{transaction_type.description} already exists!"
  end
end
