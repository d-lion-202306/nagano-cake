class OrderItem < ApplicationRecord
  belongs_to :items
  belongs_to :orders
  validates :production_status, presence: true
end
