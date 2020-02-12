FactoryBot.define do
  factory :carrier do
    name { 'Zé Transportes' }
    cnpj { '82.676.748/0001-73' }
    corporate_name { 'José dos Santos Transportes LTDA' }
    carrier_tax { '25' }
    address
  end
end
