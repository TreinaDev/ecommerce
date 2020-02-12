FactoryBot.define do
  factory :order do
    client { nil }
    status { 1 }
    order_value { '9.99' }
  end
end
