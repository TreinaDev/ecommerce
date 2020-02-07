class Carrier < ApplicationRecord
  validates :cnpj, :corporate_name, :address, presence: true
end
