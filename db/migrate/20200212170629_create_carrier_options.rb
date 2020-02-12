class CreateCarrierOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :carrier_options do |t|
      t.float :min_vol
      t.float :max_vol
      t.float :price_kg
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
