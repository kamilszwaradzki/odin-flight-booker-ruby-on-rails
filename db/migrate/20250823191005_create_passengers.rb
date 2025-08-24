class CreatePassengers < ActiveRecord::Migration[8.0]
  def change
    create_table :passengers do |t|
      t.references :booking, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :document_number

      t.timestamps
    end
  end
end
