class CartItem < ApplicationRecord
  belongs_to :items
  belongs_to :customers
  validates :amount, presence: true
end
