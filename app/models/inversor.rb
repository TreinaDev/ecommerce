class Inversor < Product
  validates :max_wattage, :max_voltage, :max_current, presence: true
end