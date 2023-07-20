class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = Customer.find(current_customer.id)
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end
  
  def update
    @customer = Customer.find(current_customer.id)
    if @customer.update(customer_params)
       flash[:notice] ="You have updated successfully."
       redirect_to customers_mypage_path
    else
      render :edit
    end
  end
  
  def confirm_withdraw
  end
  
  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number, :email)
  end
  
end
