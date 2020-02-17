FactoryBot.define do
  factory :order do
    client
    status { 0 }
    order_value { '9.99' }
  end
end
