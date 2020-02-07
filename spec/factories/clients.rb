FactoryBot.define do
  factory :client do
    email { 'cliente@example.com' }
    password { 'SenhaMuitoDificil' }
    name { 'João Pereira' }
    address { 'Rua Alameda Santos, 123' }
    zip_code { '12345-678' }
    client_type { 0 }
    document { '123456789' }
  end
end
