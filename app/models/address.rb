class Address < ApplicationRecord
  belongs_to :carrier
  validates :street, :number, :zip_code, :neighborhood, :city, :state,
            presence: true
end
