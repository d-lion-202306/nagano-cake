class Admin::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @records = Item.search_for(@word)
    @page = @records.page(params[:page]).per(10)
  end
end
