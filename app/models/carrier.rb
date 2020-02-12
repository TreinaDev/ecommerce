class Carrier < ApplicationRecord
  validates :cnpj, :corporate_name, :carrier_tax, :address, presence: true
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
end
