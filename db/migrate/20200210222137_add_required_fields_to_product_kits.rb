class AddRequiredFieldsToProductKits < ActiveRecord::Migration[6.0]
  def change
    add_column :product_kits, :description, :string
    add_column :product_kits, :price, :decimal, precision: 8, scale: 2
    add_column :product_kits, :weight, :decimal, precision: 6, scale: 2
    add_column :product_kits, :width, :integer
    add_column :product_kits, :height, :integer
    add_column :product_kits, :thickness, :integer
    add_column :product_kits, :warranty, :integer
  end
end
