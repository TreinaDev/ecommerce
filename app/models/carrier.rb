class Carrier < ApplicationRecord
  validates :cnpj, :corporate_name, :address, presence: true

  def calculate_shipping_cost(weight, height, depth, width)
    vol = (height * depth * width)
    case 
     when vol <= 1
      weight * 10
     when vol > 1 && vol <= 3
      weight * 15
     when vol > 3 && vol <= 10
      weight * 20
     when vol > 10
      weight * 25
    end
  end
end
