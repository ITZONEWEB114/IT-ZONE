class SessionsController < ApplicationController
  skip_before_filter :customer_authorize
  skip_before_filter :authorize
  def new
  end

  def create
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      redirect_to session[:page]
    else
      redirect_to login_url, :alert => "Invalid user/password conbination"
    end
  end

  def destroy
    session[:user_id] = nil;
    redirect_to store_url, :notice => "Logged out"
  end

end
