FactoryBot.define do
  factory :address do
    street { 'R. Escorrega lá vai um' }
    number { '123' }
    zip_code { '02943-000' }
    complement { 'A' }
    city { 'São Paulo' }
    state { 'SP' }
    carrier { nil }
  end
end
