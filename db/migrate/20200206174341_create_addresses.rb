class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :number
      t.string :zip_code
      t.string :complement
      t.string :city
      t.string :state
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
