class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  validates :amount, presence: true
  
  def get_image
   unless image.attached?
     file_path = Rails.root.join('app/assets/images/no_image.jpg')
     image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
    image
  end

  def tax_price
   (self.non_tax_price * 1.1).round
  end 
  
  def subtotal_payment
      item.tax_price * amount
  end
end
