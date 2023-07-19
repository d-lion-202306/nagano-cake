class Address < ApplicationRecord
  belongs_to :customers
  
  with_options presence: true do
     validates :name
     validates :post_code
     validates :address
   end
end
