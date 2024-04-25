class CreateOpposingParties < ActiveRecord::Migration[7.1]
  def change
    create_table :opposing_parties do |t|
      t.integer :client_type
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
