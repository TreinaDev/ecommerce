class Order < ApplicationRecord
  belongs_to :client
  belongs_to :product_kit

  enum status: { pending: 0 }
end
