class Public::ItemsController < ApplicationController
  def index
    @all_items = Item.all
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem
  end
  
  
end
