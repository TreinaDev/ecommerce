class OrdersController < ApplicationController
  def checkout
    @order = current_client.orders.waiting_payment.last
    @payment_options = PaymentOption.all(@order.order_value)
    @order.waiting_payment!
  end

  def confirm
    order = current_client.orders.find_by(status: :pending)
    order.waiting_payment!
    redirect_to checkout_path
  end
end
