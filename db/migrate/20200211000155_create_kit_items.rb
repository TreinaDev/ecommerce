class CreateKitItems < ActiveRecord::Migration[6.0]
  def change
    create_table :kit_items do |t|
      t.references :product, null: false, foreign_key: true
      t.references :product_kit, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
