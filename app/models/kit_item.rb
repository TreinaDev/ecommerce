class KitItem < ApplicationRecord
  belongs_to :product
  belongs_to :product_kit

  validates :quantity, numericality: { greater_than: 0 }
end
