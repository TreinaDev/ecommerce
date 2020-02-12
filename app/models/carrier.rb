class Carrier < ApplicationRecord
  validates :cnpj, :corporate_name, :address, presence: true
  has_one :address, dependent: :destroy
  has_many :carrier_options, dependent: :destroy
  accepts_nested_attributes_for :address
end
