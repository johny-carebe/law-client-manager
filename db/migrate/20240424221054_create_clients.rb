class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.integer :client_type
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
