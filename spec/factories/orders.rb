FactoryBot.define do
  factory :order do
    client { nil }
    status { 0 }
    order_value { '9.99' }
  end
end
