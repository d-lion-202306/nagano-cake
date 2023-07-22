class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items,dependent: :destroy
  has_many :order_items,dependent: :destroy

  has_one_attached :image

  with_options presence: true do
     validates :name
     validates :introduction
     validates :non_tax_price
     validates :is_active
     validates :genre_id
  end

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
end
