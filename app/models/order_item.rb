class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  validates :production_status, presence: true
  
  def subtotal_order_price
  #小計の計算:税込み価格 * 数量
    tax_price * amount
  end
  
   # 制作ステータス（0=着手不可 / 1=制作待ち / 2=制作中 / 3=制作完了）
 enum order_status: {
    "着手不可": 0,
    "制作待ち": 1,
    "制作中": 2,
    "制作完了": 3
}
end
