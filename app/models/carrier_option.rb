class CarrierOption < ApplicationRecord
  validates :min_vol, :max_vol, :price_kg, presence: true
  belongs_to :carrier
  validate :max_vol_must_be_higher_than_min_vol
  validate :price_range_must_be_unique

  def self.deliver_volume(volume)
    where('min_vol <= :volume AND max_vol >= :volume', volume: volume)
  end

  private

  def max_vol_must_be_higher_than_min_vol
    return unless min_vol.present? && max_vol.present? && price_kg.present?
    return unless min_vol >= max_vol

    errors.add(max_vol.to_s, 'O valor de volume máximo deve ser
                              maior que o volume mínimo')
  end

  def price_range_must_be_unique
    return if min_vol.blank? && max_vol.blank? && price_kg.blank?

    carrier_ranges.each do |range|
      if range.overlaps?(min_vol..max_vol)
        return errors.add(:base, 'O valor inserido já está incluído em outra ' \
                                 'opção de frete')
      end
    end
  end

  def carrier_ranges
    carrier.carrier_options.map do |c_o|
      (c_o.min_vol..c_o.max_vol)
    end
  end
end
