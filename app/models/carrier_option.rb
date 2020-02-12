class CarrierOption < ApplicationRecord
  validates :min_vol, :max_vol, :price_kg, presence: true
  belongs_to :carrier
end
