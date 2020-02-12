FactoryBot.define do
  factory :carrier_option do
    min_vol { 1.5 }
    max_vol { 1.5 }
    price_kg { 1.5 }
    carrier { "" }
  end
end
