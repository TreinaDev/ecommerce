class CarrierOptionsToRanges
  attr_accessor :carrier_options

  def initialize(carrier_options)
    @carrier_options = carrier_options
  end

  def self.new(carrier_options)
    ranges = []
    carrier_options.each do |c|
      result = c.min_vol..c.max_vol
      ranges << result
    end
    ranges
  end
end
