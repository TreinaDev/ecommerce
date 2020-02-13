class AddFieldsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :width, :integer
    add_column :products, :height, :integer
    add_column :products, :thickness, :integer
    add_column :products, :type, :string
    add_column :products, :sku, :string
    add_column :products, :rated_power, :integer
    add_column :products, :weight, :decimal, precision: 5, scale: 2
    add_column :products, :purchase_price, :decimal, precision: 6, scale: 2
    add_column :products, :efficiency, :decimal, precision: 4, scale: 2
  end
end
