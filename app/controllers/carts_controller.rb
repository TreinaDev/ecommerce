class CartsController < ApplicationController
  def show
    @order = current_client.orders.find_by(status: :pending)
    @payments_options = PaymentOption.all(@order.order_value)
  end
end
