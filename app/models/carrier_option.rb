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
    carrier_options = carrier.carrier_options.all
    ranges = CarrierOptionsToRanges.new(carrier_options)
    new_range = (min_vol..max_vol).to_a
    if ranges.each do |range|
      range = range.to_a
      range.to_i.include?(new_range.to_i)
      errors.add(:base, 'O valor inserido já está incluído em
                          outra opção de frete')
    end
    end
  end
end
