# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeopleController, type: :request do
  describe 'GET /index' do
    context 'when search params are present' do
      it 'searches for people by name or cpf_cnpj' do
        person = Person.create(
          name: 'John Doe',
          cpf_cnpj: '12345678909',
          rg: '123456789',
          ctps: '12345678988',
          pis_init: '123456789',
          marital_status: 'single',
          email: 'asd@asd.com',
          phone: '123456789',
          ocupation: 'Developer',
          full_address: '123 Main St'
        )

        get '/people', params: { search: '12345678909' }

        expect(response.body).to include(person.name)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new person' do
        person_params = {
          name: 'John Doe',
          cpf_cnpj: '123.456.789-09',
          rg: '12.345.678-9',
          ctps: '1234567/8988',
          pis_init: '123456789',
          marital_status: 'single',
          email: 'asd@asd.com',
          phone: '123456789',
          ocupation: 'Developer',
          full_address: '123 Main St'
        }

        post '/people', params: { person: person_params }

        expect(response).to redirect_to(people_path)

        expected_attributes = Person.last.attributes.symbolize_keys.slice(
          :name, :cpf_cnpj, :rg, :ctps, :pis_init, :marital_status, :email, :phone,
          :ocupation, :full_address
        )

        person_params = LawClientManager::Person::DocumentFormatter
                        .new(person_params)
                        .cpf_cnpj
                        .rg
                        .ctps
                        .pis_init
                        .format

        expect(expected_attributes).to eq(person_params)
      end
    end
  end
end
