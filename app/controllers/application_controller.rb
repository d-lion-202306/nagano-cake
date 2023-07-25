class ApplicationController < ActionController::Base

  def header
    @customer = Customer.find(params[:id])
  end

  private
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
        admin_top_path
    else
        customers_mypage_path
    end
  end

  def
    after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :customer
        root_path
    elsif resource_or_scope == :admin
          new_admin_session_path
    end
  end
end
