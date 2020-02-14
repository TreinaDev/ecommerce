class CarrierOption < ApplicationRecord
  validates :min_vol, :max_vol, :price_kg, presence: true
  belongs_to :carrier
  validate :max_vol_must_be_higher_than_min_vol
  validate :price_range_must_be_unique

  private

  def max_vol_must_be_higher_than_min_vol
    return unless min_vol.present? && max_vol.present? && price_kg.present?
    return unless min_vol >= max_vol

    errors.add(max_vol.to_s, 'O valor de volume máximo deve ser
                              maior que o volume mínimo')
  end

  def price_range_must_be_unique
    return unless min_vol.present? && max_vol.present? && price_kg.present?

    carrier_options = carrier.carrier_options.all
    carrier_options.each do |c_o|
      ranges = CarrierOptionsToRanges.convert(c_o.min_vol, c_o.max_vol)
      result = ranges.to_a & (min_vol..max_vol).to_a
      if result.empty? == false
        errors.add(:base, 'O valor inserido já está incluído em
                              outra opção de frete')
      end
    end
  end
end
