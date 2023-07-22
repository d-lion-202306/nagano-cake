class Public::AddressesController < ApplicationController
  
  def index
    @new_address = Address.new
    @addresses = Address.all
    #一覧ページから配送先のidを取得したい
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path
    else
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def update
     @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to 
    else
      render 
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end
  
  private

  def address_params
    params.require(:address).permit(:name, :post_code, :address)
  end
end