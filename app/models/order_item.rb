class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product_kit

  def update_total_value
    order.update(order_value: order.product_kits.sum(&:price))
  end
end
