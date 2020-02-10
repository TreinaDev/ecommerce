class ProductKit < ApplicationRecord
  has_one_attached :picture
  validates :name, :weight, :width, :height, :thickness, :price, :warranty,
            presence: true
end
