class ProductKit < ApplicationRecord
  has_one_attached :picture
  has_many :kit_items, dependent: :destroy
  has_many :products, through: :kit_items
  has_many :orders
  validates :name, :weight, :width, :height, :thickness, :price, :warranty,
            presence: true
end
