class CartsController < ApplicationController
  
  def show
    @carrier_options = CarrierOption.all
    @order = current_client.orders.find_by(status: :pending)
    @payments_options = PaymentOption.all(@order.order_value) if @order
    total_vol = CarrierPriceCalculator.new(@carrier_options, @order).total_vol
    total_weight = CarrierPriceCalculator.new(@carrier_options, @order).total_weight
    @carrier_attributes = CarrierPriceCalculator.new(@carrier_options, @order).calculate(total_vol, total_weight)
  end
end
