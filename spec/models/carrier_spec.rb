require 'rails_helper'

RSpec.describe Carrier, type: :model do
  context '#calculate_shipping_cost' do
    it 'should calculate the shipping cost correctly when vol = 0.5' do
      carrier = build(:carrier)

      weight = 5
      height = 2
      depth = 0.5
      width = 0.5

      result = carrier.calculate_shipping_cost(weight, height, depth, width)
 
      expect(result).to match(50)
    end   
    it 'should calculate the shipping cost correctly when vol = 1' do
      carrier = build(:carrier)

      weight = 2
      height = 2
      depth = 1
      width = 0.5

      result = carrier.calculate_shipping_cost(weight, height, depth, width)
 
      expect(result).to match(20)
    end
    it 'should calculate the shipping cost correctly when vol = 2' do
      carrier = build(:carrier)

      weight = 5
      height = 2
      depth = 1
      width = 1

      result = carrier.calculate_shipping_cost(weight, height, depth, width)
 
      expect(result).to match(75)
    end
    it 'should calculate the shipping cost correctly when vol = 3' do
      carrier = build(:carrier)

      weight = 8
      height = 3
      depth = 1
      width = 1

      result = carrier.calculate_shipping_cost(weight, height, depth, width)
 
      expect(result).to match(120)
    end
    it 'should calculate the shipping cost correctly when vol = 6' do
      carrier = build(:carrier)

      weight = 7
      height = 2
      depth = 3
      width = 1

      result = carrier.calculate_shipping_cost(weight, height, depth, width)
 
      expect(result).to match(140)
    end
    it 'should calculate the shipping cost correctly when vol = 10' do
      carrier = build(:carrier)

      weight = 5
      height = 5
      depth = 2
      width = 1

      result = carrier.calculate_shipping_cost(weight, height, depth, width)
 
      expect(result).to match(100)
    end
    it 'should calculate the shipping cost correctly when vol = 11' do
      carrier = build(:carrier)

      weight = 10
      height = 5.5
      depth = 2
      width = 1

      result = carrier.calculate_shipping_cost(weight, height, depth, width)
 
      expect(result).to match(250)
    end
    it 'should calculate the shipping cost correctly when vol = 80' do
      carrier = build(:carrier)

      weight = 100
      height = 40
      depth = 2
      width = 1

      result = carrier.calculate_shipping_cost(weight, height, depth, width)
 
      expect(result).to match(2500)
    end
  end
end
