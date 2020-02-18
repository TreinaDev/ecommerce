class CarrierPriceCalculator
  attr_reader :carrier_options, :order

  def initialize(carrier_options, order)
    @carrier_options = carrier_options
    @order = order
  end

  def self
  end

  def total_vol
    unless order.product_kits.nil?
      volumes = []
      order.product_kits.all.each do |kit|
        volumes << (kit.width/1000) * (kit.height/1000) * (kit.thickness/1000)
      end
      volumes.sum
    end
  end

  def total_weight
    unless order.product_kits.nil?
      weights = []
      order.product_kits.all.each do |kit|
        weights << kit.weight
      end
      weights.sum
    end
  end

  def calculate(total_vol, total_weight)
    carrier_attributes = nil
    carrier_options.map do |c_o|
      return unless (c_o.min_vol..c_o.max_vol).include?(total_vol)
      carrier_attributes = choose_carrier(c_o)
    end
    carrier_attributes
  end

  def choose_carrier(c_o)
    avaiable_carrier_options = []
    carrier_name = []
    if avaiable_carrier_options.count == 1
      if avaiable_carrier_options[0] < (total_weight * c_o.price_kg)
        avaiable_carrier_options[0]
      else
        avaiable_carrier_options[0] == (total_weight * c_o.price_kg)
        carrier_name << c_o.carrier.name
      end
    else
      avaiable_carrier_options << (total_weight * c_o.price_kg)
      carrier_name << c_o.carrier.name
    end
    result = {name: (carrier_name.join), price: (avaiable_carrier_options.join)}
  end
end
