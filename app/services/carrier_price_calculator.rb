class CarrierPriceCalculator
  attr_reader :carrier_options, :order

  def initialize(carrier_options, order)
    @carrier_options = carrier_options
    @order = order
  end

  def total_vol
    return if order.nil?

    vols = []
    order.product_kits.all.each do |kit|
      vols << (kit.width / 1000) * (kit.height / 1000) * (kit.thickness / 1000)
    end
    vols.sum
  end

  def total_weight
    return if order.nil?

    weights = []
    order.product_kits.all.each do |kit|
      weights << kit.weight
    end
    weights.sum
  end

  def calculate(total_vol, _total_weight)
    avaiable_carrier_options = []
    carrier_name = []
    carrier_attributes = nil
    carrier_options.map do |c_o|
      return unless (c_o.min_vol..c_o.max_vol).include?(total_vol)

      carrier_attributes = choose_carrier(c_o, avaiable_carrier_options,
                                          carrier_name)
    end
    carrier_attributes
  end

  def choose_carrier(c_o, avaiable_carrier_options, carrier_name)
    if avaiable_carrier_options.count == 1
      if avaiable_carrier_options[0] < (total_weight * c_o.price_kg)
        avaiable_carrier_options[0]
      else
        avaiable_carrier_options[0] = (total_weight * c_o.price_kg)
        carrier_name << c_o.carrier.name
      end
    else
      avaiable_carrier_options << (total_weight * c_o.price_kg)
      carrier_name << c_o.carrier.name
    end
    { name: carrier_name.join, price: avaiable_carrier_options.join }
  end
end
