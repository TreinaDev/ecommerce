class CarrierPriceCalculator
  attr_reader :carrier_options, :order

  def initialize(carrier_options, order)
    @carrier_options = carrier_options
    @order = order
  end

  def total_vol
    return if order.nil?

    order.product_kits.reduce(0) do |sum, kit|
      sum + (kit.width / 1000) * (kit.height / 1000) * (kit.thickness / 1000)
    end
  end

  def total_weight
    return if order.nil?

    order.product_kits.reduce(0) { |sum, kit| sum + kit.weight }
  end

  def calculate(total_vol, total_weight)
    avaiable_carrier_options = CarrierOption.deliver_volume(total_vol)
    carrier = avaiable_carrier_options.order(price_kg: :asc).first
    return if carrier.blank?

    { name: carrier.carrier.name, price: carrier.price_kg * total_weight }
  end
end
