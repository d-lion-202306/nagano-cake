class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  belongs_to :customer
  
  with_options presence: true do
     validates :name
     validates :post_code
     validates :address
     validates :payment_method
     validates :postage
     validates :total_payment
     validates :order_status
 end
 
 enum payment_method: {
   クレジットカード: 0,
   銀行振込: 1
 }
end
