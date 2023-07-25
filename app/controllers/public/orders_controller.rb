class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.item_id = cart.item_id
        order_item.order_id = @order.id
        order_item.amount = cart.amount
        order_item.tax_price = cart.item.non_tax_price
        order_item.save
        end
      cart_items.destroy_all
      redirect_to complete_orders_path
    else
      @order = Order.new(order_params)
      render :new
    end
  end


  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == '1'
      @order.name = current_customer.address
      @order.address = current_customer.address
      @order.post_code = current_customer.post_code
    elsif params[:order][:address_number] == '2'
        add = Address.find(params[:order][:registered])
        @order.name = add.name
        @order.address = add.address
        @order.post_code = add.post_code
    elsif params[:order][:address_number] == '3'
        @order.post_code = params[:order][:post_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
    else
      redirect_to items_path
    end
    @postage = 800
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) {|sum, item| sum + item.subtotal_payment}
  end

  def complete
  end

  def index
    @orders = current_customer.orders.page(params[:page]).per(8)
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit( :customer_id, :name, :address, :total_payment, :post_code, :postage, :payment_method)
  end

  def address_params
    params.require(:order).permit(:name, :address)
  end

end
