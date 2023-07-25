class Admin::OrderItemsController < ApplicationController
  def update
    @order = Order.find(params[:id])
    @order_item = OrderItem.find(params[:id])
    @order_items = @order.order_items.all
    
    is_update = true
    if @order_item.update(order_item_params)
       @order.update(order_status: 2) if @order_item.production_status == "production"
    # 製作ステータスが「製作中」のときに、注文ステータスを「製作中」に更新する。
       @order_items.each do |order_item| 
       if order_item.production_status != "complete"
         is_update = false
       end
     end
     @order.update(order_status: 3) if is_update
   end
    redirect_to admin_order_path(params[:id])
  end
  
  private
  
  def order_item_params
    params.require(:order_item).permit(:production_status)
  end
end
