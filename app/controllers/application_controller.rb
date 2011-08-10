class ApplicationController < ActionController::Base
  before_filter :set_i18n_locale_from_params
  before_filter :record_current_url
  before_filter :authorize
  protect_from_forgery
  
  private 
	
	def current_cart
	  Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
  	  cart = Cart.create
	  session[:cart_id] = cart.id
	  cart
	end
	
	protected
	
	def authorize
	  unless User.find_by_id(session[:user_id])
	    redirect_to login_url, :notice => "Please log in"
	  end
	end
	
	def customer_authorize
	  unless Customer.find_by_id(session[:customer_id])
	    redirect_to customer_admin_login_url, :notice => "Please log in"
	  end
	end
	
	def record_current_url
	  unless request.fullpath == customer_admin_login_path || request.fullpath == login_path
	    session[:page] = request.fullpath
	  end
	end
	def set_i18n_locale_from_params
	  if params[:locale]
	    if I18n.available_locales.include?(params[:locale].to_sym)
	      I18n.locale = params[:locale]
	    else
	      flash.now[:notice] = "#{params[:locale]} translation not available"
	      logger.error flash.now[:notice]
	    end
	  end
	end
	
	def default_url_options
	  { :locale => I18n.locale}
	end
end