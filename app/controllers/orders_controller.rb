class OrdersController < ApplicationController
  before_action :fetch_order, only: %i[checkout payment]
  def checkout
    @order.waiting_payment!
  end

  def confirm
    order = current_client.orders.find_by(status: :pending)
    order.waiting_payment!
    redirect_to checkout_path
  end

  def payment
    order_id = @order.id
    type = params[:selected_option]
    find = @payment_options.first { |obj| obj.name == type }
    find.post_api(order_id)
    @order.in_progress!
    redirect_to root_path, notice: 'Pedido realizado com sucesso.'
  end

  private

  def fetch_order
    @order = current_client.orders.waiting_payment.last
    @payment_options = PaymentOption.all(@order.order_value)
  end
end
