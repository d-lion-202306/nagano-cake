class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
    @genre = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @genre = Genre.all
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def index
    @item = Item.new
    @items = Item.page(params[:page])
    @genre = Genre.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genre = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    @genre = Genre.all
    if @item.update(item_params)
      redirect_to admin_items_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :non_tax_price, :is_active, :image)
  end

end
