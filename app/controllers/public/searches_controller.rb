class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @records = Item.search_for(@word)
  end
end
