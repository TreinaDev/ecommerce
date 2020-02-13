class ProductKit < ApplicationRecord
  has_one_attached :picture
  has_many :kit_items, dependent: :destroy
  has_many :products, through: :kit_items
  validates :name, :weight, :width, :height, :thickness, :price, :warranty,
            presence: true

  validates :name, case_sensitive: false, uniqueness: true
end
