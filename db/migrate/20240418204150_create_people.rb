class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.string :name
      t.integer :marital_status
      t.string :ocupation
      t.string :rg
      t.string :cpf
      t.string :ctps
      t.string :pis_init
      t.string :full_address
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
