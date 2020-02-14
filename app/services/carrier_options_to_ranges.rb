class CarrierOptionsToRanges
  attr_accessor :min_vol, :max_vol

  def initialize(min_vol, max_vol)
    @min_vol = min_vol
    @max_vol = max_vol
  end

  def self.convert(min_vol, max_vol)
    result = min_vol..max_vol
    result
  end
end
