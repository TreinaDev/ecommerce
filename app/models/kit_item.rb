class KitItem < ApplicationRecord
  belongs_to :product
  belongs_to :product_kit
end
