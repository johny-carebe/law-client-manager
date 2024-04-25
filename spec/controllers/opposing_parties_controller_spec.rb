# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpposingPartiesController, type: :request do
  let(:person) do
    Person.create(
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
  end

  describe 'GET /index' do
    context 'when search params are present' do
      it 'searches for people by name or cpf_cnpj' do
        OpposingParty.create(person:, client_type: :defendant)

        get '/opposing_parties', params: { search: '12345678909' }

        expect(response.body).to include(person.name)
      end
    end
  end

  describe 'POST /edit_client_type' do
    context 'with valid parameters' do
      it 'edits the client type' do
        opposing_party = OpposingParty.create(person:, client_type: :defendant)

        post(
          edit_client_type_opposing_party_path(opposing_party),
          params: { client_type: :plaintiff }
        )

        expect(opposing_party.reload.client_type).to eq('plaintiff')
      end
    end
  end
end
