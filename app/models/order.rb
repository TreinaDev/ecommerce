class Order < ApplicationRecord
  belongs_to :client

  enum status: { pending: 0 }
end
