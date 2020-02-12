class AddInversorFieldsToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :max_wattage, :integer
    add_column :products, :max_voltage, :integer
    add_column :products, :max_current, :decimal, precision: 5, scale: 2
  end
end
