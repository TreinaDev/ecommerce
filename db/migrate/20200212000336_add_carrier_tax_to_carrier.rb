class AddCarrierTaxToCarrier < ActiveRecord::Migration[6.0]
  def change
    add_column :carriers, :carrier_tax, :integer
  end
end
