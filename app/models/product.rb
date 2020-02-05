class Product < ApplicationRecord
  validates :name, :width, :height, :thickness, :sku, :weight, presence: true
end
