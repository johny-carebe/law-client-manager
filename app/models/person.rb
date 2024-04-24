# frozen_string_literal: true

class Person < ApplicationRecord
  enum marital_status: {
    single: 0,
    married: 1,
    divorced: 2,
    widowed: 3,
    civil_union: 4
  }

  validates :name, :cpf_cnpj, presence: true
  validates :cpf_cnpj, :rg, :ctps, :pis_init, uniqueness: true, allow_nil: true
end
