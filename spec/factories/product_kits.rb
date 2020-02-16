FactoryBot.define do
  factory :product_kit do
    name { 'Kit Familiar' }
    description { 'Cupidatat duis nulla ipsum ullamco in sunt non et sit.' }
    price { 20_000.0 }
    weight { 300 }
    width { 2000 }
    height { 1500 }
    thickness { 1000 }
    warranty { 3 }

    trait :with_picture do
      # TODO: futuramente para testar com fotos
    end
  end
end
