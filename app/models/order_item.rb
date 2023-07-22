class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  validates :production_status, presence: true
end
