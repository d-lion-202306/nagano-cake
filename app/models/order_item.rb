class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order
  validates :production_status, presence: true
  
   # 制作ステータス（0=着手不可 / 1=制作待ち / 2=制作中 / 3=制作完了）
 enum production_status: {
    impossible: 0,
    waiting: 1,
    production: 2,
    complete: 3
}
end
