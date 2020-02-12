class AddNewFieldsToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :name, :string
    add_column :clients, :address, :string
    add_column :clients, :zip_code, :string
    add_column :clients, :client_type, :integer, default: 0
    add_column :clients, :document, :string
  end
end
