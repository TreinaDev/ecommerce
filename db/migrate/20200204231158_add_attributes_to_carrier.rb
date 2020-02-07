class AddAttributesToCarrier < ActiveRecord::Migration[6.0]
  def change
    add_column :carriers, :cnpj, :string
    add_column :carriers, :corporate_name, :string
    add_column :carriers, :address, :string
  end
end
