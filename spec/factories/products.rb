FactoryBot.define do
  factory :product do
    name { 'Produto Solar' }
    width { 100 }
    height { 200 }
    thickness { 300 }
    sku { 'WGA-123-BSBK' }
    weight { 10 }
    purchase_price { 2000.0 }

    trait :solar_plate do
      type { 'SolarPlate' }
      rated_power { 325 }
      efficiency { 13 }
    end

    trait :inversor do
      type { 'Inversor' }
      max_wattage { 5000 }
      max_voltage { 600 }
      max_current { 17.0 }
    end
  end
end