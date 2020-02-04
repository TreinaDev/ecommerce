class CreateProductKits < ActiveRecord::Migration[6.0]
  def change
    create_table :product_kits do |t|
      t.string :name

      t.timestamps
    end
  end
end
