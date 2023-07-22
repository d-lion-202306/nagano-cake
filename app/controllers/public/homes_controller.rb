class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @items = Item.first(3)
  end

  def about
  end
end
