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
        order_item.order_amount = cart.amount
        order_item.order_price = cart.item.non_tax_price
        order_item.save
      end
      redirect_to orders_complete_path
      cart_items.destroy_all
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
      if Address.exists?(name: params[:order][:registered])
        @order.name = Address.find(params[:order][:registered]).name
        @order.address = Address.find(params[:order][:registered]).address
      else
        render :new
      end
    elsif params[:order][:address_number] == '3'
      address_new = current_customer.address.new(address_params)
      if address_new.save
      else
        render :new
      end
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
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :total_payment, :post_code, :postage, :payment_method)
  end

  def address_params
    params.require(:order).permit(:name, :address)
  end

end
