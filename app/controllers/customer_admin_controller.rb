class CustomerAdminController < ApplicationController
  skip_before_filter :customer_authorize
  skip_before_filter :authorize
  
  def login
    
  end
  
  def judge
    if customer = Customer.authenticate(params[:name], params[:password])
      if customer.is_activated == true
      session[:customer_id] = customer.id
      redirect_to session[:page]
      else
        redirect_to customer_admin_login_url, :alert => "Please activated the account"
      end
    else
      redirect_to customer_admin_login_url, :alert => "Invalid user/password conbination"
    end
  end

  def confirm
    customer = Customer.find_by_name(params[:name])
    
    # 如果用户不为空，且用户处于未激活状态，且用户输入的激活码正确
    if customer != nil && customer.is_activated == false && customer.active_code == params[:active_code] then    
    # 修改激活状态
    customer.update_attribute(:is_activated , true)
    flash[:notice] = "恭喜您，您已经成功激活了您的账户！"
    # 如果用户已经处于激活状态
    elsif customer != nil && customer.is_activated == true then
    flash[:notice] = "您的账户已经处于激活状态，请勿重复激活！"
    else
    flash[:notice] = "激活失败！"
    end
  end
  
  def logout
      session[:customer_id] = nil
      redirect_to store_url, :notice => "Logged out"
    end
end
