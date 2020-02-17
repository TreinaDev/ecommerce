class CartsController < ApplicationController
  def show
    @carrier_options = CarrierOption.all
    @order = current_client.orders.find_by(status: :pending)
    @payments_options = PaymentOption.all(@order.order_value) if @order
    @total_vol = total_vol
    @total_weight = total_weight

    avaiable_carrier_options = []
    carrier_name = []
    @carrier_options.map do |c_o|
      return unless (c_o.min_vol..c_o.max_vol).include?(@total_vol)

      if avaiable_carrier_options.count == 1
        if avaiable_carrier_options[0] < (@total_weight * c_o.price_kg)
          avaiable_carrier_options[0]
        else
          avaiable_carrier_options[0] == (@total_weight * c_o.price_kg)
          carrier_name << c_o.carrier.name
        end
      else
        avaiable_carrier_options << (@total_weight * c_o.price_kg)
        carrier_name << c_o.carrier.name
      end
    end
    @carrier_name = carrier_name.join
    @carrier_price = avaiable_carrier_options.join
  end

  private

  def total_vol
    volumes = []
    @order.product_kits.all.each do |kit|
      volumes << (kit.width/1000) * (kit.height/1000) * (kit.thickness/1000)
    end
    volumes.sum
  end

  def total_weight
    weights = []
    @order.product_kits.all.each do |kit|
      weights << kit.weight
    end
    weights.sum
  end
end
