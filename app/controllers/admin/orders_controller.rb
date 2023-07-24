class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @address = Address.find(params[:id])
    
    items = Item.find(params[:id])
    order_items = Order_item.find(params[:id])
    #@ordersにItemモデルとOrder_itemモデルの情報を追加
    @order_items = items | order_items
    
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_orders_path
    
    @order_items = Order_item.find(params[:id])
    @order_items.update(order_item_params)
    redirect_to admin_orders_path
  end
  
  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
  
  def order_item_params
    params.require(:order_item).permit(:production_status)
  end

end
