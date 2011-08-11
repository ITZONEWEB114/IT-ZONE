class StoreController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :customer_authorize
  def index
	 if params[:set_locale]
	    redirect_to store_path(:locale => params[:set_locale])
	 else
	    @products = Product.all
	    @hotProducts = Product.find([1,2]);
      @cart = current_cart
	 end
  end

end
