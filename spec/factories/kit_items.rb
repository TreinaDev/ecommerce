FactoryBot.define do
  factory :kit_item do
    product
    product_kit
    quantity { 1 }
  end
end
