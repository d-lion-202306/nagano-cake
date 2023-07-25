class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: params[:id])
    if @order.update(order_params)
       @order_items.update_all(production_status: 1) if @order.order_status == "paid_up"
      ## ①注文ステータスが「入金確認」のとき、製作ステータスを全て「製作待ち」に更新する
    redirect_to admin_order_path(@order.id)
    end
  end

  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
end