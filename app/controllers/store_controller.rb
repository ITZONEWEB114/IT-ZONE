class StoreController < ApplicationController
  
  skip_before_filter :authorize
  
  def index
		if params[:set_locale]
			redirect_to store_path(:locale => params[:set_locale])
		elsif params[:category]
			@products, @isAll, flash[:notice] = Product.getProducts params
		else
			@products = Product.all
			@isAll = true
		end
		@cart = current_cart
  end
	
	def show
		begin
			@product = Product.find(params[:product_id])
		rescue
			redirect_to store_path, :notice => "Product not found"
		end
		@cart = current_cart
	end

	def search
	end
end
