class Order < ApplicationRecord
  belongs_to :client
  has_many :order_items, dependent: :destroy
  has_many :product_kits, through: :order_items

  enum status: { pending: 0, waiting_payment: 5, in_progress: 10, accepted: 15,
                 declined: 20 }
end
