class OrdersController < ApplicationController
  def checkout
    @order = current_client.orders.find_by(status: :pending)
    @payment_options = PaymentOption.all(@order.order_value)
    @order.waiting_payment!
  end
end