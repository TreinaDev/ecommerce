require 'rails_helper'

RSpec.describe Carrier, type: :model do
  context '#calculate_shipping_cost' do
    it 'should calculate the shipping cost correctly' do
      carrier = build(:carrier)

      weight = 5
      height = 2
      depth = 3
      width = 1

      result = carrier.calculate_shipping_cost(weight, height, depth, width)
 
      expect(result).to match(100)
    end
  end
end
