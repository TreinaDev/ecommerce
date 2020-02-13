class CarrierOption < ApplicationRecord
  validates :min_vol, :max_vol, :price_kg, presence: true
  belongs_to :carrier
  validate :max_vol_must_be_higher_than_min_vol

  private

  def max_vol_must_be_higher_than_min_vol
    return unless min_vol >= max_vol

    errors.add(max_vol.to_s, 'O valor de volume máximo deve ser
                              maior que o volume mínimo')
  end
end
