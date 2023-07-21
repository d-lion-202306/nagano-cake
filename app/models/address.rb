class Address < ApplicationRecord
  belongs_to :customer
  
  with_options presence: true do
     validates :name
     validates :post_code
     validates :address
   end
end
