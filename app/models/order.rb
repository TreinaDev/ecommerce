class Order < ApplicationRecord
  belongs_to :client
  has_many :order_items, dependent: :destroy
  has_many :product_kits, through: :order_items

  enum status: { pending: 0, in_progress: 5, waiting_payment: 10, accepted: 15,
                 declined: 20 }
end
