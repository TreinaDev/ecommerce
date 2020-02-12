class Product < ApplicationRecord
  has_many :kit_items, dependent: :destroy
  has_many :product_kits, through: :kit_items
  validates :name, :width, :height, :thickness, :sku, :weight, presence: true
end
