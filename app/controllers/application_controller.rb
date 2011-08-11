class ApplicationController < ActionController::Base
	before_filter :set_i18n_locale_from_params
	before_filter :backtrack_path
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
	
	def current_user
		User.find_by_id(session[:user_id])
	end

  protected
	def authorize
		unless User.find_by_id(session[:user_id]) || User.count.zero?
			#flash[:backtrack_path] = request.path
			redirect_to login_url, :alert => "Please login"
		end
	end
	
	def backtrack_path
		unless request.fullpath == login_path
			session[:backtrack_path] = request.fullpath
		end
	end
	
	def set_i18n_locale_from_params
		if params[:locale]
			if I18n.available_locales.include?(params[:locale].to_sym)
				I18n.locale = params[:locale]
			else
				flash.now[:notice]=
					"#{params[:locale]} translation not availbel"
				logger.error flash.now[:notice]
			end
		end
	end
	
	def  default_url_options
		{ :locale => I18n.locale }
	end
end
