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
    "入金待ち": 0,
    "入金確認": 1,
    "制作中": 2,
    "発送準備中": 3,
    "発送済み": 4
}

#請求金額
def total_paayment_of_billed 
  postage + total_payment
end


end
