class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
 has_many :addresses, dependent: :destroy
 has_many :cart_items, dependent: :destroy
 has_many :orders, dependent: :destroy
 
   with_options presence: true do
     validates :last_name
     validates :first_name
     validates :last_name_kana
     validates :first_name_kana
     validates :post_code
     validates :address
     validates :telephone_number
   end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  def full_name
    last_name+"　"+first_name
  end
  
  def full_name_kana
    last_name_kana+"　"+first_name_kana
  end
  
end
