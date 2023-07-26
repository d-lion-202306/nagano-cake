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
 
 # 注文ステータス（0=入金待ち / 1=入金確認 / 2=制作中 / 3=発送準備中/ 4=発送済み）
 enum order_status: {
    waiting: 0,
    paid_up: 1,
    producting: 2,
    preparing: 3,
    sented: 4
}

#請求金額
def total_paayment_of_billed 
  postage + total_payment
end
 def subtotal_order_price
#小計の計算:税込み価格 * 数量
  tax_price * amount
 end
 
 def total_amount
     OrderItem.all.sum(:amount)
 end


end
