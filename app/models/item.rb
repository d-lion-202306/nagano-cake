class Item < ApplicationRecord
  belongs_to :genres
  has_many :cart_items,dependent: :destroy
  has_many :order_items,dependent: :destroy
  
  has_one_attached :image
  
  with_options presence: true do
     validates :name
     validates :item_status
     validates :item_status
  end
  
  #def get_image
   # unless image.attached?
    #  file_path = Rails.root.join('app/assets/images/no_image.jpg')
     # image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    #end
    #image
  #end 
end
