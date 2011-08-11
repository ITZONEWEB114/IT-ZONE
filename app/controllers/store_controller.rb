class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
		if params[:set_locale]
			redirect_to store_path(:locale => params[:set_locale])
		else
			@products = Product.all
			@cart = current_cart
		end
  end
	
	def show
		begin
			@product = Product.find(params[:product_id])
		rescue
			redirect_to store_path, :notice => "Product not found"
		end
		@cart = current_cart
    @comments = Comment.where(:product_id=>@product)
	end

end
