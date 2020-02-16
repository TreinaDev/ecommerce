class AddProductKitToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :product_kit, foreign_key: true
  end
end
