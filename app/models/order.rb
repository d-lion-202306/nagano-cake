class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customers
  
  with_options presence: true do
     validates :name
     validates :post_code
     validates :address
     validates :payment_method
     validates :postage
     validates :total_payment
     validates :order_status
end
