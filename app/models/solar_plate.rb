class SolarPlate < Product
  validates :rated_power, :efficiency, presence: true
end