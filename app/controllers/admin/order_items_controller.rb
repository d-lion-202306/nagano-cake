class Admin::OrderItemsController < ApplicationController

  def show
      @orders = Order.page(params[:page])
      #@order = Order.find(params[:id])
  end
  
  def update
      @order_item = OrderItem.find(params[:id])
      @order_item.update(order_item_params)
      @order = @order_item.order
      @order_items = @order.order_items
      if @order_item.production_status == "production"
         @order.update(order_status: "producting")
      elsif @order_items.where(production_status: "complete").count == @order_items.count
         @order.update(order_status: "preparing")
      end
      flash[:notice] = "製作ステータスが更新されました"
      redirect_to request.referrer
  end

  private

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end

end