class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    orders = Order.page(params[:page])
    order_items = Order_item.page(params[:page])
    #@ordersにorderモデルとorder_itemモデルの情報を追加
    @orders = orders | order_items
  end
end
