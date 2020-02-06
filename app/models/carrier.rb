class Carrier < ApplicationRecord
  validates :cnpj, :corporate_name, :address, presence: true
  has_one :address
  accepts_nested_attributes_for :address
end
