class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @records = Item.search_for(@word)
    @page = @records.page(params[:page]).per(8)
  end
end
