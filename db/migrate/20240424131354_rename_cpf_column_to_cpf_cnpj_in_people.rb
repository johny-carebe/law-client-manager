class RenameCpfColumnToCpfCnpjInPeople < ActiveRecord::Migration[7.1]
  def change
    rename_column :people, :cpf, :cpf_cnpj
  end
end
