FactoryBot.define do
  factory :carrier do
    name { 'Zé Transportes' }
    cnpj { '82.676.748/0001-73' }
    corporate_name { 'José dos Santos Transportes LTDA' }
    address_attributes { attributes_for(:address) }
  end
end
