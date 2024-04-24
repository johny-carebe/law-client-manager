# frozen_string_literal: true

module LawClientManager
  module Person
    class DocumentFormatter
      def initialize(person)
        @person = person
      end

      def format
        @person
      end

      def rg
        @person[:rg] = remove_characters(@person[:rg])
        self
      end

      def cpf_cnpj
        @person[:cpf_cnpj] = remove_characters(@person[:cpf_cnpj])
        self
      end

      def ctps
        @person[:ctps] = remove_characters(@person[:ctps])
        self
      end

      def pis_init
        @person[:pis_init] = remove_characters(@person[:pis_init])
        self
      end

      private

      def remove_characters(document)
        document.gsub(/\D/, '') unless document.blank?
      end
    end
  end
end
