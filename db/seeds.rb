# frozen_string_literal: true

require 'faker'

# Create 40 people
40.times do
  Person.create(
    name: Faker::Name.name,
    cpf_cnpj: Faker::IdNumber.brazilian_citizen_number,
    rg: Faker::IdNumber.brazilian_id,
    ctps: Faker::IdNumber.brazilian_citizen_number,
    pis_init: Faker::IdNumber.brazilian_citizen_number,
    marital_status: Person.marital_statuses.keys.sample,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone,
    ocupation: Faker::Job.title,
    full_address: Faker::Address.full_address
  )
end
